def city_prefix: if startswith("city:") then . else "city:\(.)" end;
# def get_target: .objectSelector | if (.idPatterns | type == "array" and length > 0) or (.path | length > 1) then "chek:document" else (.path[0] | city_prefix) end;
def get_path: if .path | length > 0 then
    (if .child then ["?obj\(.i - 1) city:hasChild ?obj\(.i)"] else [] end)
    + ["?obj\(.i // 0) a \(.path[0] | city_prefix)"]
    + ({ "i": ((.i // 0) + 1), "path": .path[1:], "geometrySurface": .geometrySurface, "child": true } | get_path)
  else
    if .geometrySurface == false then
      []
    else
      ["?obj\(.i - 1) city:hasGeometry/city:hasSurface ?surface"]
      + if .geometrySurface then
        ["?surface a \(.geometrySurface | city_prefix)"]
      else
        ["?surface a city:NonSemanticSurface"]
      end
    end
  end;
def get_lod_filter: if .lod.min then
    if (.lod.min | contains(".")) then
      (.lod.min | split(".") | "^[\(.[0])-4]\\.[\(.[1])-4]$")
    else
      "^[\(.lod.min)-4](\\.[0-4])?$"
    end
  else
    .lod.regex
  end | "FILTER REGEX(?lod, \"\(.)\")";
def get_select: [
  "\nSELECT (?rootObject as $this) (?value as ?path) WHERE {",
    "  " + ({ "path": .objectSelector.path, "geometrySurface": (if .requiredSubPath | length then false else .objectSelector.geometrySurface end) } | get_path | join(" .\n  ")) + " .",
    "  FILTER NOT EXISTS {",
    "    " + ({ "path": .objectSelector.requiredSubPath, "geometrySurface": .objectSelector.geometrySurface, "i": (.objectSelector.path | length), "child": true } | get_path | join(" .\n    ")) + " .",
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
      #"sh:targetNode": { "@id": (. | get_target) },
      "sh:targetNode": { "@id": "chek:document" },
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