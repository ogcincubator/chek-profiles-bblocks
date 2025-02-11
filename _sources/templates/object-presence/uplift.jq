def escape_regex: . | gsub("\\\\"; "\\\\") | gsub("\""; "\\\"");
def city_prefix: if startswith("city:") then . else "city:\(.)" end;
def get_path: (.i // 0) as $I | (if (.path | length == 1) and (.lastThis) then .lastThis else "?obj\($I)" end) as $THIS | if .path | length > 0 then
    (if .parent then ["\(.parent) city:hasChild \($THIS)"] else [] end)
    + ["\($THIS) a \(.path[0] | city_prefix)"]
    + ({ "i": ($I + 1), "path": .path[1:], "geometrySurface": .geometrySurface, "parent": $THIS, "lastThis": "?this" } | get_path)
  else
    []
  end;
def getIdPatternsMatcher: map("{ FILTER REGEX(?identifier, \"\(. | escape_regex)\") }") | join("\n  UNION\n  ") |
  "$this dct:identifier ?identifier .\n  " + .;
def get_object_selector:
  if .objectSelector.idPatterns then
    .objectSelector.idPatterns | getIdPatternsMatcher
  else
    { "path": .objectSelector.path, "geometrySurface": false, "lastThis": "?last" } | get_path | join(" .\n  ") + " ."
  end;
def get_select: [
  "\nSELECT $this (city:hasObject as ?path) (city:\(.objectSelector.path[-1]) as ?value) WHERE {",
    "  FILTER NOT EXISTS {",
    "    " + get_object_selector,
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
      "message": (.message // "Required city object is not present"),
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
        { "sh:prefix": "dct", "sh:namespace": { "@value": "http://purl.org/dc/terms/", "@type": "xsd:anyURI" } },
        { "sh:prefix": "chek", "sh:namespace": { "@value": "urn:chek:vocab/", "@type": "xsd:anyURI" } }
      ]
    }
  ]
}