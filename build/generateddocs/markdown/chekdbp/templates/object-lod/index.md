
# Object Level of Detail (LoD) (Schema)

`ogc.chekdbp.templates.object-lod` *v0.1*

Creates a rule to validate the LoD of a given element or set of elements

[*Status*](http://www.opengis.net/def/status): Under development

## Examples

### Minimum LoD 2.1+ for buildings
#### json
```json
{
  "id": "my-rule",
  "label": "My sample rule for buildings",
  "objectSelector": {
    "path": [
      "Building"
    ]
  },
  "lod": {
    "min": "2.1"
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "My sample rule for buildings",
      "description": null,
      "message": "Invalid Level of Detail (lod) for object",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT (?rootObject as $this) (?value as ?path) WHERE {\n  ?obj0 a city:Building .\n  FILTER NOT EXISTS {\n    ?obj0 city:hasGeometry/city:hasSurface ?surface .\n    ?surface a city:NonSemanticSurface .\n    ?surface city:lod ?lod .\n    FILTER REGEX(?lod, \"^[2-4]\\.[1-4]$\")\n  }\n}"
      },
      "sh:severity": {
        "@id": "sh:Violation"
      }
    },
    {
      "@id": "prefixes",
      "@type": "owl:Ontology",
      "owl:imports": {
        "@id": "sh:"
      },
      "sh:declare": [
        {
          "sh:prefix": "city",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdf",
          "sh:namespace": {
            "@value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdfs",
          "sh:namespace": {
            "@value": "http://www.w3.org/2000/01/rdf-schema#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "sd",
          "sh:namespace": {
            "@value": "https://w3id.org/okn/o/sd#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "attr",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/attr#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "dct",
          "sh:namespace": {
            "@value": "http://purl.org/dc/terms/",
            "@type": "xsd:anyURI"
          }
        }
      ]
    }
  ]
}
```

#### ttl
```ttl
@prefix chek: <urn:chek:vocab/> .
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Invalid Level of Detail (lod) for object" ;
    sh:name "My sample rule for buildings" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT (?rootObject as $this) (?value as ?path) WHERE {
  ?obj0 a city:Building .
  FILTER NOT EXISTS {
    ?obj0 city:hasGeometry/city:hasSurface ?surface .
    ?surface a city:NonSemanticSurface .
    ?surface city:lod ?lod .
    FILTER REGEX(?lod, "^[2-4]\\.[1-4]$")
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ] .


```


### Minumum LoD 3 for buildings
#### json
```json
{
  "id": "my-rule",
  "label": "My sample rule for buildings",
  "objectSelector": {
    "path": [
      "Building"
    ]
  },
  "lod": {
    "min": "3"
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "My sample rule for buildings",
      "description": null,
      "message": "Invalid Level of Detail (lod) for object",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT (?rootObject as $this) (?value as ?path) WHERE {\n  ?obj0 a city:Building .\n  FILTER NOT EXISTS {\n    ?obj0 city:hasGeometry/city:hasSurface ?surface .\n    ?surface a city:NonSemanticSurface .\n    ?surface city:lod ?lod .\n    FILTER REGEX(?lod, \"^[3-4](\\.[0-4])?$\")\n  }\n}"
      },
      "sh:severity": {
        "@id": "sh:Violation"
      }
    },
    {
      "@id": "prefixes",
      "@type": "owl:Ontology",
      "owl:imports": {
        "@id": "sh:"
      },
      "sh:declare": [
        {
          "sh:prefix": "city",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdf",
          "sh:namespace": {
            "@value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdfs",
          "sh:namespace": {
            "@value": "http://www.w3.org/2000/01/rdf-schema#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "sd",
          "sh:namespace": {
            "@value": "https://w3id.org/okn/o/sd#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "attr",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/attr#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "dct",
          "sh:namespace": {
            "@value": "http://purl.org/dc/terms/",
            "@type": "xsd:anyURI"
          }
        }
      ]
    }
  ]
}
```

#### ttl
```ttl
@prefix chek: <urn:chek:vocab/> .
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Invalid Level of Detail (lod) for object" ;
    sh:name "My sample rule for buildings" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT (?rootObject as $this) (?value as ?path) WHERE {
  ?obj0 a city:Building .
  FILTER NOT EXISTS {
    ?obj0 city:hasGeometry/city:hasSurface ?surface .
    ?surface a city:NonSemanticSurface .
    ?surface city:lod ?lod .
    FILTER REGEX(?lod, "^[3-4](\\.[0-4])?$")
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ] .


```


### Minumum LoD 3.2 for WallSurface in Buildings
#### json
```json
{
  "id": "my-rule",
  "label": "My sample rule for buildings",
  "objectSelector": {
    "path": [
      "Building"
    ],
    "geometrySurface": "WallSurface"
  },
  "lod": {
    "min": "3.2"
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "My sample rule for buildings",
      "description": null,
      "message": "Invalid Level of Detail (lod) for object",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT (?rootObject as $this) (?value as ?path) WHERE {\n  ?obj0 a city:Building .\n  FILTER NOT EXISTS {\n    ?obj0 city:hasGeometry/city:hasSurface ?surface .\n    ?surface a city:WallSurface .\n    ?surface city:lod ?lod .\n    FILTER REGEX(?lod, \"^[3-4]\\.[2-4]$\")\n  }\n}"
      },
      "sh:severity": {
        "@id": "sh:Violation"
      }
    },
    {
      "@id": "prefixes",
      "@type": "owl:Ontology",
      "owl:imports": {
        "@id": "sh:"
      },
      "sh:declare": [
        {
          "sh:prefix": "city",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdf",
          "sh:namespace": {
            "@value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdfs",
          "sh:namespace": {
            "@value": "http://www.w3.org/2000/01/rdf-schema#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "sd",
          "sh:namespace": {
            "@value": "https://w3id.org/okn/o/sd#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "attr",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/attr#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "dct",
          "sh:namespace": {
            "@value": "http://purl.org/dc/terms/",
            "@type": "xsd:anyURI"
          }
        }
      ]
    }
  ]
}
```

#### ttl
```ttl
@prefix chek: <urn:chek:vocab/> .
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Invalid Level of Detail (lod) for object" ;
    sh:name "My sample rule for buildings" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT (?rootObject as $this) (?value as ?path) WHERE {
  ?obj0 a city:Building .
  FILTER NOT EXISTS {
    ?obj0 city:hasGeometry/city:hasSurface ?surface .
    ?surface a city:WallSurface .
    ?surface city:lod ?lod .
    FILTER REGEX(?lod, "^[3-4]\\.[2-4]$")
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ] .


```


### Mininum LoD with regular expression for GroundSurface of Building / BuildingPart
#### json
```json
{
  "id": "my-rule",
  "label": "My sample rule for buildings",
  "objectSelector": {
    "path": [
      "Building",
      "BuildingPart"
    ],
    "geometrySurface": "GroundSurface"
  },
  "lod": {
    "regex": "^(2\\.[2-4]|[34](\\.*)?)$"
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "My sample rule for buildings",
      "description": null,
      "message": "Invalid Level of Detail (lod) for object",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT (?rootObject as $this) (?value as ?path) WHERE {\n  ?obj0 a city:Building .\n  ?obj0 city:hasChild ?obj1 .\n  ?obj1 a city:BuildingPart .\n  FILTER NOT EXISTS {\n    ?obj1 city:hasGeometry/city:hasSurface ?surface .\n    ?surface a city:GroundSurface .\n    ?surface city:lod ?lod .\n    FILTER REGEX(?lod, \"^(2\\.[2-4]|[34](\\.*)?)$\")\n  }\n}"
      },
      "sh:severity": {
        "@id": "sh:Violation"
      }
    },
    {
      "@id": "prefixes",
      "@type": "owl:Ontology",
      "owl:imports": {
        "@id": "sh:"
      },
      "sh:declare": [
        {
          "sh:prefix": "city",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdf",
          "sh:namespace": {
            "@value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdfs",
          "sh:namespace": {
            "@value": "http://www.w3.org/2000/01/rdf-schema#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "sd",
          "sh:namespace": {
            "@value": "https://w3id.org/okn/o/sd#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "attr",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/attr#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "dct",
          "sh:namespace": {
            "@value": "http://purl.org/dc/terms/",
            "@type": "xsd:anyURI"
          }
        }
      ]
    }
  ]
}
```

#### ttl
```ttl
@prefix chek: <urn:chek:vocab/> .
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Invalid Level of Detail (lod) for object" ;
    sh:name "My sample rule for buildings" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT (?rootObject as $this) (?value as ?path) WHERE {
  ?obj0 a city:Building .
  ?obj0 city:hasChild ?obj1 .
  ?obj1 a city:BuildingPart .
  FILTER NOT EXISTS {
    ?obj1 city:hasGeometry/city:hasSurface ?surface .
    ?surface a city:GroundSurface .
    ?surface city:lod ?lod .
    FILTER REGEX(?lod, "^(2\\.[2-4]|[34](\\.*)?)$")
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ] .


```


### Require that all BuildingPart's inside Building's have at least one BuildingInstallation with a WallSurface of LoD >= 2.
#### json
```json
{
  "id": "my-rule",
  "label": "My sample rule for buildings",
  "objectSelector": {
    "path": [
      "Building",
      "BuildingPart"
    ],
    "requiredSubPath": [
      "BuildingInstallation"
    ],
    "geometrySurface": "WallSurface"
  },
  "lod": {
    "min": "2"
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "My sample rule for buildings",
      "description": null,
      "message": "Invalid Level of Detail (lod) for object",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT (?rootObject as $this) (?value as ?path) WHERE {\n  ?obj0 a city:Building .\n  ?obj0 city:hasChild ?obj1 .\n  ?obj1 a city:BuildingPart .\n  FILTER NOT EXISTS {\n    ?obj1 city:hasChild ?obj2 .\n    ?obj2 a city:BuildingInstallation .\n    ?obj2 city:hasGeometry/city:hasSurface ?surface .\n    ?surface a city:WallSurface .\n    ?surface city:lod ?lod .\n    FILTER REGEX(?lod, \"^[2-4](\\.[0-4])?$\")\n  }\n}"
      },
      "sh:severity": {
        "@id": "sh:Violation"
      }
    },
    {
      "@id": "prefixes",
      "@type": "owl:Ontology",
      "owl:imports": {
        "@id": "sh:"
      },
      "sh:declare": [
        {
          "sh:prefix": "city",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdf",
          "sh:namespace": {
            "@value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "rdfs",
          "sh:namespace": {
            "@value": "http://www.w3.org/2000/01/rdf-schema#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "sd",
          "sh:namespace": {
            "@value": "https://w3id.org/okn/o/sd#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "attr",
          "sh:namespace": {
            "@value": "http://example.com/vocab/city/attr#",
            "@type": "xsd:anyURI"
          }
        },
        {
          "sh:prefix": "dct",
          "sh:namespace": {
            "@value": "http://purl.org/dc/terms/",
            "@type": "xsd:anyURI"
          }
        }
      ]
    }
  ]
}
```

#### ttl
```ttl
@prefix chek: <urn:chek:vocab/> .
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Invalid Level of Detail (lod) for object" ;
    sh:name "My sample rule for buildings" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT (?rootObject as $this) (?value as ?path) WHERE {
  ?obj0 a city:Building .
  ?obj0 city:hasChild ?obj1 .
  ?obj1 a city:BuildingPart .
  FILTER NOT EXISTS {
    ?obj1 city:hasChild ?obj2 .
    ?obj2 a city:BuildingInstallation .
    ?obj2 city:hasGeometry/city:hasSurface ?surface .
    ?surface a city:WallSurface .
    ?surface city:lod ?lod .
    FILTER REGEX(?lod, "^[2-4](\\.[0-4])?$")
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ] .


```

## Schema

```yaml
$schema: https://json-schema.org/draft/2020-12/schema
type: object
allOf:
- $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/base-rule/schema.yaml
- required:
  - objectSelector
  - lod
  properties:
    objectSelector:
      allOf:
      - $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.yaml
      - type: object
        properties:
          requiredSubPath:
            description: Array with city object path, starting from the last element
              of "path", that is required to be present.
            minItems: 1
            $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.yaml#/$defs/CityObjectArray
          geometrySurface:
            description: Geometry surface on which the LoD will be checked.
            type: string
    lod:
      description: Level of detail
      type: object
      oneOf:
      - required:
        - regex
        properties:
          regex:
            description: Regular expression to validate the LoD.
            type: string
      - required:
        - min
        properties:
          min:
            description: Minimum allowed LoD. Can be simple (2) or extended (2.1).
              If extended an LoD is used, only extended values will be allowed.
            type: string
            pattern: ^[0-3](\.[0-3])$

```

Links to the schema:

* YAML version: [schema.yaml](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/schema.json)
* JSON version: [schema.json](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/schema.yaml)


# JSON-LD Context

```jsonld
{
  "@context": {
    "@base": "http://example.com/change-me/",
    "id": "@id",
    "description": "sh:description",
    "message": "sh:message",
    "label": "sh:name",
    "sh": "http://www.w3.org/ns/shacl#",
    "my-rule": "http://example.com/change-me/",
    "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
    "dct": "http://purl.org/dc/terms/",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "owl": "http://www.w3.org/2002/07/owl#",
    "city": "http://example.com/vocab/city/",
    "attr": "city:attr#",
    "sd": "https://w3id.org/okn/o/sd#",
    "chek": "urn:chek:vocab/",
    "@version": 1.1
  }
}
```

You can find the full JSON-LD context here:
[context.jsonld](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-lod/context.jsonld)


# For developers

The source code for this Building Block can be found in the following repository:

* URL: [https://github.com/ogcincubator/chek-profiles-bblocks](https://github.com/ogcincubator/chek-profiles-bblocks)
* Path: `_sources/templates/object-lod`

