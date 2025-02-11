def escape_regex: . | gsub("\""; "\\\"");
def city_prefix: if startswith("city:") then . else "city:\(.)" end;
def get_path: (.i // 0) as $I | (if (.path | length == 1) and (.lastThis) then .lastThis else "?obj\($I)" end) as $THIS | if .path | length > 0 then
    (if .parent then ["\(.parent) city:hasChild \($THIS)"] else [] end)
    + ["\($THIS) a \(.path[0] | city_prefix) ."]
    + ({ "i": ($I + 1), "path": .path[1:], "geometrySurface": .geometrySurface, "parent": $THIS, "lastThis": "?this" } | get_path)
  else
    if .geometrySurface == false or (.parent | not) then
      []
    elif .geometrySurface then
      [
        "\(.parent) city:hasGeometry/city:hasSurface ?surface .",
        "?surface a \(.geometrySurface | city_prefix) ."
      ]
    else
      []
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
def get_id_patterns_matcher: map("{ FILTER REGEX(?identifier, \"\(. | escape_regex)\") }") | join("\n  UNION\n  ") |
  "$this dct:identifier ?identifier .\n  " + .;
def escape_attribute_value:
  if type == "string" then
    "\"\(. | escape_regex)\""
  end
;
def get_attribute_filter($var):
  to_entries | map(select(.key | test("^(=|[<>]=?|regex)$")) |
    if .key == "regex" then
      "REGEX($var; \"\(.value | escape_regex)\")"
    else
      "$var \(.key) \(.value | escape_attribute_value)"
    end
  )
;
def get_attributes:
  (if .objectSelector.geometrySurface then "?surface" elif .objectSelector.requiredSubPath then "?this" else "$this" end) as $SUBJECT |
  .attributes | to_entries | to_entries | map(
    .key as $IDX | .value.key as $ATTR | "?attr\($IDX)" as $ATTR_VAL | .value.value as $VAL |
    (if $VAL.required then ["", "&&"] else ["!", "||"] end) as $FILTER_OPS | ($VAL | get_attribute_filter($ATTR_VAL) | join(" && ")) as $FILTER_CONDS |
    if ($VAL.required or ($FILTER_CONDS | length > 0)) then
      [
        "OPTIONAL { \($SUBJECT) attr:\($ATTR) \($ATTR_VAL) } .",
        get_attribute_filter("?fake"),
        "FILTER(\($FILTER_OPS[0])" + "BOUND(\($ATTR_VAL))" + (if $FILTER_CONDS | length > 0 then " \($FILTER_OPS[1]) (\($FILTER_CONDS))" else "" end) + ")"
      ]
    else
      []
    end
  ) | flatten
;
def get_target: [
  "\nSELECT ?this WHERE {",
  "  " + (if .objectSelector.idPatterns then
            .objectSelector.idPatterns | get_id_patterns_matcher
          else
            { "path": .objectSelector.path, "geometrySurface": false, "lastThis": "?this" } | get_path | join("\n  ")
          end),
  "}"
];
def get_select: [
  "\nSELECT $this (city:lod as ?path) (?lod as ?value) WHERE {",
    "  FILTER NOT EXISTS {",
    "    " + ({ "path": .objectSelector.requiredSubPath, "geometrySurface": .objectSelector.geometrySurface, "parent": "$this" } | get_path | join("    ")),
    "    " + (get_attributes | join("\n    ")),
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