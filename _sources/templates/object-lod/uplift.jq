def escape_regex: . | gsub("\\\\"; "\\\\") | gsub("\""; "\\\"");
def city_prefix: if startswith("city:") then . else "city:\(.)" end;
def get_path: (.i // 0) as $I | (if (.path | length == 1) and (.lastThis) then .lastThis else "?obj\($I)" end) as $THIS | if .path | length > 0 then
    (if .parent then ["\(.parent) city:hasChild \($THIS)"] else [] end)
    + ["\($THIS) a \(.path[0] | city_prefix)"]
    + ({ "i": ($I + 1), "path": .path[1:], "geometrySurface": .geometrySurface, "parent": $THIS, "lastThis": "?this" } | get_path)
  else
    if .geometrySurface == false or (.parent | not) then
      []
    else
      ["\(.parent) city:hasGeometry/city:hasSurface ?surface"]
      + if .geometrySurface then
        ["?surface a \(.geometrySurface | city_prefix)"]
      else
        ["?surface a city:NonSemanticSurface"]
      end
    end
  end;
def get_lod_filter: if .lod.min then
    if (.lod.min | contains(".")) then
      (.lod.min | split(".") | "^[\(.[0])-4]\\\\.[\(.[1])-4]$")
    else
      "^[\(.lod.min)-4](\\\\.[0-4])?$"
    end
  else
    .lod.regex
  end | "FILTER REGEX(?lod, \"\(. | escape_regex )\")";
def get_target: [
  "SELECT ?this WHERE {",
  "  " + ({ "path": .objectSelector.path, "geometrySurface": false, "lastThis": "?this" } | get_path | join(" .\n  ")) + " .",
  "}"
];
def get_select: [
  "\nSELECT $this (city:lod as ?path) (?lod as ?value) WHERE {",
    "  FILTER NOT EXISTS {",
    "    " + ({ "path": .objectSelector.requiredSubPath, "geometrySurface": .objectSelector.geometrySurface, "parent": "$this" } | get_path | join(" .\n    ")) + " .",
    "    ?surface city:lod ?lod ." ,
    "    \(get_lod_filter)",
    "  }",
  "}"
];
{
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": .id,
      "label": .label,
      "description": .description,
      "message": (.message // "Invalid Level of Detail (lod) for object"),
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": { "@id": "my-rule:prefixes" },
        "sh:select": (. | get_target | join("\n"))
      },
      "sh:sparql": {
        "sh:prefixes": { "@id": "my-rule:prefixes" },
        "sh:select": (. | get_select | join("\n"))
      },
      "sh:severity": { "@id": "sh:Violation" }
    },
    {
      "@id": "prefixes",
      "@type": "owl:Ontology",
      "owl:imports": {
        "@id": "sh:"
      },
      "sh:declare": [
        { "sh:prefix": "city", "sh:namespace": { "@value": "http://example.com/vocab/city/", "@type": "xsd:anyURI" } },
        { "sh:prefix": "rdf", "sh:namespace": { "@value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#", "@type": "xsd:anyURI" } },
        { "sh:prefix": "rdfs", "sh:namespace": { "@value": "http://www.w3.org/2000/01/rdf-schema#", "@type": "xsd:anyURI" } },
        { "sh:prefix": "sd", "sh:namespace": { "@value": "https://w3id.org/okn/o/sd#", "@type": "xsd:anyURI" } },
        { "sh:prefix": "attr", "sh:namespace": { "@value": "http://example.com/vocab/city/attr#", "@type": "xsd:anyURI" } },
        { "sh:prefix": "dct", "sh:namespace": { "@value": "http://purl.org/dc/terms/", "@type": "xsd:anyURI" } }
      ]
    }
  ]
}