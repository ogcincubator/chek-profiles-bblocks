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
def get_id_patterns_matcher: map("{ FILTER REGEX(?identifier, \"\(. | escape_regex)\") }") | join("\n  UNION\n  ") |
  "$this dct:identifier ?identifier .\n  " + .;
def escape_attribute_value:
  if type == "string" then
    "\"\(. | escape_regex)\""
  end
;
def get_attribute_filter:
  to_entries | map(select(.key | test("^(=|[<>]=?|regex)$")) |
    if .key == "regex" then
      "REGEX(?value; \"\(.value | escape_regex)\")"
    else
      "?value \(.key) \(.value | escape_attribute_value)"
    end
  )
;
def get_attribute:
  (if .rule.objectSelector.geometrySurface then "?surface" elif .rule.objectSelector.requiredSubPath then "?this" else "$this" end) as $SUBJECT |
  .attr |
  (.value | get_attribute_filter | join(" && ")) as $FILTER_CONDS |
  if ((.value.required | not) and ($FILTER_CONDS | length == 0)) then
    []
  else
    "\($SUBJECT) <http://example.com/vocab/city/attr#\(.key | @uri)> ?value" as $TRIPLE |
    [if (.value.required | not) then "OPTIONAL { \($TRIPLE) }" else $TRIPLE end]
    + [ if ($FILTER_CONDS | length > 0) then
          "FILTER(" + if (.value.required | not) then "!BOUND(?value)" + (if $FILTER_CONDS | length > 0 then " || (\($FILTER_CONDS))" else "" end) else $FILTER_CONDS end + ")"
        else
          empty
        end
      ]
  end
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
def get_selects: [(.attributes | to_entries)[] as $ATTR | [
  "\nSELECT $this (<http://example.com/vocab/city/attr#\($ATTR.key | @uri)> as ?path) ?value WHERE {",
  "  FILTER NOT EXISTS {",
  "    " + ({ "path": .objectSelector.requiredSubPath, "geometrySurface": .objectSelector.geometrySurface, "parent": "$this" } | get_path | select(.) | join("\n    ")),
  "    " + ({ "attr": $ATTR, "rule": .} | get_attribute | select(.) | join("\n    ")),
  "  }",
  "}"
] | join("\n")]
;
{
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": .id,
      "label": .label,
      "description": .description,
      "message": (.message // "Invalid or missing attribute value"),
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": { "@id": "my-rule:prefixes" },
        "sh:select": (. | get_target | join("\n"))
      },
      "sh:sparql": (get_selects | map({
        "sh:prefixes": { "@id": "my-rule:prefixes" },
        "sh:select": .
      })),
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