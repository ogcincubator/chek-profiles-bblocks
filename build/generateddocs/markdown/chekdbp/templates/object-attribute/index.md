
# Object Attribute (Schema)

`ogc.chekdbp.templates.object-attribute` *v0.1*

Creates a rule to validate the existence and/or value of an attribute in an object or set of objects

[*Status*](http://www.opengis.net/def/status): Under development

## Examples

### Require that all Buildings have a "hasWalls" attribute
#### json
```json
{
  "id": "my-rule",
  "label": "Check Building.hasWalls",
  "message": "Some Building objects have no hasWalls attribute",
  "objectSelector": {
    "path": [
      "Building"
    ]
  },
  "attributes": {
    "hasWalls": {
      "required": true
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Building.hasWalls",
      "description": null,
      "message": "Some Building objects have no hasWalls attribute",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Building .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    $this <http://example.com/vocab/city/attr#hasWalls> ?value\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Some Building objects have no hasWalls attribute" ;
    sh:name "Check Building.hasWalls" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    $this <http://example.com/vocab/city/attr#hasWalls> ?value
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Building .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ] .


```


### Require that all Buildings have a "hasWalls" attribute with `true` value
#### json
```json
{
  "id": "my-rule",
  "label": "Check Building.hasWalls is true",
  "message": "Some Building objects have no hasWalls attribute equal to true",
  "objectSelector": {
    "path": [
      "Building"
    ]
  },
  "attributes": {
    "hasWalls": {
      "required": true,
      "=": true
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Building.hasWalls is true",
      "description": null,
      "message": "Some Building objects have no hasWalls attribute equal to true",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Building .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    $this <http://example.com/vocab/city/attr#hasWalls> ?value\n    FILTER(?value = true)\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Some Building objects have no hasWalls attribute equal to true" ;
    sh:name "Check Building.hasWalls is true" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    $this <http://example.com/vocab/city/attr#hasWalls> ?value
    FILTER(?value = true)
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Building .
}""" ] .

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
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ] .


```


### Check that the "hasWalls" attribute is always true for Building/BuildingPart, but do not require it.
#### json
```json
{
  "id": "my-rule",
  "label": "Check Building.hasWalls is true",
  "message": "Some Building objects have no hasWalls attribute equal to true",
  "objectSelector": {
    "path": [
      "Building",
      "BuildingPart"
    ]
  },
  "attributes": {
    "hasWalls": {
      "required": false,
      "=": true
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Building.hasWalls is true",
      "description": null,
      "message": "Some Building objects have no hasWalls attribute equal to true",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?obj0 a city:Building .\n  ?obj0 city:hasChild ?this\n  ?this a city:BuildingPart .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    OPTIONAL { $this <http://example.com/vocab/city/attr#hasWalls> ?value }\n    FILTER(!BOUND(?value) || (?value = true))\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Some Building objects have no hasWalls attribute equal to true" ;
    sh:name "Check Building.hasWalls is true" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    OPTIONAL { $this <http://example.com/vocab/city/attr#hasWalls> ?value }
    FILTER(!BOUND(?value) || (?value = true))
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?obj0 a city:Building .
  ?obj0 city:hasChild ?this
  ?this a city:BuildingPart .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ] .


```


### Require that all Buildings have a "height" attribute with a value between 1 and 10
#### json
```json
{
  "id": "my-rule",
  "label": "Check Building.height is present and between 1 and 10",
  "message": "Some Building objects have no height or height is invalid",
  "objectSelector": {
    "path": [
      "Building"
    ]
  },
  "attributes": {
    "height": {
      "required": true,
      ">=": 1,
      "<=": 10
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Building.height is present and between 1 and 10",
      "description": null,
      "message": "Some Building objects have no height or height is invalid",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Building .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#height> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    $this <http://example.com/vocab/city/attr#height> ?value\n    FILTER(?value >= 1 && ?value <= 10)\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Some Building objects have no height or height is invalid" ;
    sh:name "Check Building.height is present and between 1 and 10" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#height> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    $this <http://example.com/vocab/city/attr#height> ?value
    FILTER(?value >= 1 && ?value <= 10)
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Building .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ] .


```


### Require that all Roads have a "status" attribute with a value of "paved"
#### json
```json
{
  "id": "my-rule",
  "label": "Check Road.status",
  "message": "Some Road objects have no status or status is not 'paved'",
  "objectSelector": {
    "path": [
      "Road"
    ]
  },
  "attributes": {
    "status": {
      "required": true,
      "=": "paved"
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Road.status",
      "description": null,
      "message": "Some Road objects have no status or status is not 'paved'",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Road .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#status> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    $this <http://example.com/vocab/city/attr#status> ?value\n    FILTER(?value = \"paved\")\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Some Road objects have no status or status is not 'paved'" ;
    sh:name "Check Road.status" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#status> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    $this <http://example.com/vocab/city/attr#status> ?value
    FILTER(?value = "paved")
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Road .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ] .


```


### Require values for the "status" attribute of Road objects, when present, is either "paved" or "dirt"
#### json
```json
{
  "id": "my-rule",
  "label": "Check Road.status",
  "message": "The status of the Road object is not one of 'paved' or 'dirt'",
  "objectSelector": {
    "path": [
      "Road"
    ]
  },
  "attributes": {
    "status": {
      "required": false,
      "regex": "^(paved|dirt)$"
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Road.status",
      "description": null,
      "message": "The status of the Road object is not one of 'paved' or 'dirt'",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Road .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#status> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    OPTIONAL { $this <http://example.com/vocab/city/attr#status> ?value }\n    FILTER(!BOUND(?value) || (REGEX(?value; \"^(paved|dirt)$\")))\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "The status of the Road object is not one of 'paved' or 'dirt'" ;
    sh:name "Check Road.status" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#status> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    OPTIONAL { $this <http://example.com/vocab/city/attr#status> ?value }
    FILTER(!BOUND(?value) || (REGEX(?value; "^(paved|dirt)$")))
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Road .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ] .


```


### Require that all Building objects have at least one BuildingPart containing a WallSurface with a `hasWindows`
attribute with value `1`.

#### json
```json
{
  "id": "my-rule",
  "label": "Check Building.BuildingPart.hasWindows is 1",
  "message": "Some Building objects do not have at least one BuildingPart with hasWindows set to 1",
  "objectSelector": {
    "path": [
      "Building"
    ],
    "requiredSubPath": [
      "BuildingPart"
    ]
  },
  "attributes": {
    "hasWalls": {
      "required": true,
      "=": 1
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Building.BuildingPart.hasWindows is 1",
      "description": null,
      "message": "Some Building objects do not have at least one BuildingPart with hasWindows set to 1",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Building .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    $this city:hasChild ?obj0\n    ?obj0 a city:BuildingPart .\n    ?this <http://example.com/vocab/city/attr#hasWalls> ?value\n    FILTER(?value = 1)\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Some Building objects do not have at least one BuildingPart with hasWindows set to 1" ;
    sh:name "Check Building.BuildingPart.hasWindows is 1" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#hasWalls> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    $this city:hasChild ?obj0
    ?obj0 a city:BuildingPart .
    ?this <http://example.com/vocab/city/attr#hasWalls> ?value
    FILTER(?value = 1)
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Building .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ] .


```


### Require that all Road objects have status = paved and width >= 1.

#### json
```json
{
  "id": "my-rule",
  "label": "Check Road.status and Road.width",
  "message": "Check that Road.status is present and has value 'paved', and that Road.width is at least 1",
  "objectSelector": {
    "path": [
      "Road"
    ]
  },
  "attributes": {
    "status": {
      "required": true,
      "=": "paved"
    },
    "width": {
      "required": true,
      ">=": 1
    }
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "my-rule",
      "label": "Check Road.status and Road.width",
      "description": null,
      "message": "Check that Road.status is present and has value 'paved', and that Road.width is at least 1",
      "sh:target": {
        "@type": "sh:SPARQLTarget",
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT ?this WHERE {\n  ?this a city:Road .\n}"
      },
      "sh:sparql": [
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#status> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    $this <http://example.com/vocab/city/attr#status> ?value\n    FILTER(?value = \"paved\")\n  }\n}"
        },
        {
          "sh:prefixes": {
            "@id": "my-rule:prefixes"
          },
          "sh:select": "\nSELECT $this (<http://example.com/vocab/city/attr#width> as ?path) ?value WHERE {\n  FILTER NOT EXISTS {\n    \n    $this <http://example.com/vocab/city/attr#width> ?value\n    FILTER(?value >= 1)\n  }\n}"
        }
      ],
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
@prefix my-rule: <http://example.com/change-me/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

my-rule:my-rule a sh:NodeShape ;
    sh:message "Check that Road.status is present and has value 'paved', and that Road.width is at least 1" ;
    sh:name "Check Road.status and Road.width" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#width> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    $this <http://example.com/vocab/city/attr#width> ?value
    FILTER(?value >= 1)
  }
}""" ],
        [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (<http://example.com/vocab/city/attr#status> as ?path) ?value WHERE {
  FILTER NOT EXISTS {
    
    $this <http://example.com/vocab/city/attr#status> ?value
    FILTER(?value = "paved")
  }
}""" ] ;
    sh:target [ a sh:SPARQLTarget ;
            sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT ?this WHERE {
  ?this a city:Road .
}""" ] .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ] .


```

## Schema

```yaml
$schema: https://json-schema.org/draft/2020-12/schema
$defs:
  scalar:
    not:
      anyOf:
      - type: object
      - type: array
type: object
allOf:
- $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/base-rule/schema.yaml
- required:
  - objectSelector
  properties:
    objectSelector:
      allOf:
      - $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.yaml
      - type: object
        properties:
          requiredSubPath:
            description: 'Array with city object path, starting from the last element
              of "path", that is required to be present.

              If this is provided, only one of the objects in this sub path will have
              to comply with the attribute

              requirements.

              '
            minItems: 1
            $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.yaml#/$defs/CityObjectArray
          geometrySurface:
            description: 'Geometry surface on which the attribute will be checked.

              Only one geometry surface is required to comply with the attribute requirements.

              '
            type: string
    attributes:
      description: Attributes to be checked
      additionalProperties:
        type: object
        minProperties: 1
        additionalProperties: false
        properties:
          required:
            type: boolean
            default: false
          regex:
            type: string
        patternProperties:
          ^(=|>|>=|<|<=)$:
            $ref: '#/$defs/scalar'

```

Links to the schema:

* YAML version: [schema.yaml](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/schema.json)
* JSON version: [schema.json](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/schema.yaml)


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
[context.jsonld](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-attribute/context.jsonld)


# For developers

The source code for this Building Block can be found in the following repository:

* URL: [https://github.com/ogcincubator/chek-profiles-bblocks](https://github.com/ogcincubator/chek-profiles-bblocks)
* Path: `_sources/templates/object-attribute`

