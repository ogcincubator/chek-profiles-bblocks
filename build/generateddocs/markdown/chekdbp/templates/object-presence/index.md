
# Object Presence (Schema)

`ogc.chekdbp.templates.object-presence` *v0.1*

Creates a rule to validate the existence of a set of City Objects

[*Status*](http://www.opengis.net/def/status): Under development

## Description

Verifies that at least one element that follows the parent-child hierarchy declared in `objectSelector.path`
exists in the dataset.
## Examples

### Require that at least one Road is present
#### json
```json
{
  "id": "roads-present",
  "label": "Checks that roads are present",
  "message": "No roads found in the dataset",
  "objectSelector": {
    "path": [
      "Road"
    ]
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-presence/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "roads-present",
      "label": "Checks that roads are present",
      "description": null,
      "message": "No roads found in the dataset",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT $this (city:hasObject as ?path) (city:Road as ?value) WHERE {\n  FILTER NOT EXISTS {\n    ?last a city:Road .\n  }\n}"
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
        },
        {
          "sh:prefix": "chek",
          "sh:namespace": {
            "@value": "urn:chek:vocab/",
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

my-rule:roads-present a sh:NodeShape ;
    sh:message "No roads found in the dataset" ;
    sh:name "Checks that roads are present" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (city:hasObject as ?path) (city:Road as ?value) WHERE {
  FILTER NOT EXISTS {
    ?last a city:Road .
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "urn:chek:vocab/"^^xsd:anyURI ;
            sh:prefix "chek" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ] .


```


### Require that at least one BuildingInstallation inside a BuildingPart that is, in turn, inside a Building is present
#### json
```json
{
  "id": "roads-present",
  "label": "Checks that at least one Building > BuildingPart > BuildingInstallation is present",
  "message": "No Building > BuildingPart > BuildingInstallation found",
  "objectSelector": {
    "path": [
      "Building",
      "BuildingPart",
      "BuildingInstallation"
    ]
  }
}
```

#### jsonld
```jsonld
{
  "@context": "https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-presence/context.jsonld",
  "@graph": [
    {
      "@type": "sh:NodeShape",
      "id": "roads-present",
      "label": "Checks that at least one Building > BuildingPart > BuildingInstallation is present",
      "description": null,
      "message": "No Building > BuildingPart > BuildingInstallation found",
      "sh:targetNode": {
        "@id": "chek:document"
      },
      "sh:sparql": {
        "sh:prefixes": {
          "@id": "my-rule:prefixes"
        },
        "sh:select": "\nSELECT $this (city:hasObject as ?path) (city:BuildingInstallation as ?value) WHERE {\n  FILTER NOT EXISTS {\n    ?obj0 a city:Building .\n  ?obj0 city:hasChild ?obj1 .\n  ?obj1 a city:BuildingPart .\n  ?obj1 city:hasChild ?this .\n  ?this a city:BuildingInstallation .\n  }\n}"
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
        },
        {
          "sh:prefix": "chek",
          "sh:namespace": {
            "@value": "urn:chek:vocab/",
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

my-rule:roads-present a sh:NodeShape ;
    sh:message "No Building > BuildingPart > BuildingInstallation found" ;
    sh:name "Checks that at least one Building > BuildingPart > BuildingInstallation is present" ;
    sh:severity sh:Violation ;
    sh:sparql [ sh:prefixes my-rule:prefixes ;
            sh:select """
SELECT $this (city:hasObject as ?path) (city:BuildingInstallation as ?value) WHERE {
  FILTER NOT EXISTS {
    ?obj0 a city:Building .
  ?obj0 city:hasChild ?obj1 .
  ?obj1 a city:BuildingPart .
  ?obj1 city:hasChild ?this .
  ?this a city:BuildingInstallation .
  }
}""" ] ;
    sh:targetNode chek:document .

my-rule:prefixes a owl:Ontology ;
    owl:imports sh: ;
    sh:declare [ sh:namespace "https://w3id.org/okn/o/sd#"^^xsd:anyURI ;
            sh:prefix "sd" ],
        [ sh:namespace "http://www.w3.org/1999/02/22-rdf-syntax-ns#"^^xsd:anyURI ;
            sh:prefix "rdf" ],
        [ sh:namespace "urn:chek:vocab/"^^xsd:anyURI ;
            sh:prefix "chek" ],
        [ sh:namespace "http://example.com/vocab/city/"^^xsd:anyURI ;
            sh:prefix "city" ],
        [ sh:namespace "http://example.com/vocab/city/attr#"^^xsd:anyURI ;
            sh:prefix "attr" ],
        [ sh:namespace "http://www.w3.org/2000/01/rdf-schema#"^^xsd:anyURI ;
            sh:prefix "rdfs" ],
        [ sh:namespace "http://purl.org/dc/terms/"^^xsd:anyURI ;
            sh:prefix "dct" ] .


```

## Schema

```yaml
$schema: https://json-schema.org/draft/2020-12/schema
type: object
allOf:
- $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/base-rule/schema.yaml
- required:
  - objectSelector
  properties:
    objectSelector:
      $ref: https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.yaml

```

Links to the schema:

* YAML version: [schema.yaml](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-presence/schema.json)
* JSON version: [schema.json](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-presence/schema.yaml)


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
[context.jsonld](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-presence/context.jsonld)


# For developers

The source code for this Building Block can be found in the following repository:

* URL: [https://github.com/ogcincubator/chek-profiles-bblocks](https://github.com/ogcincubator/chek-profiles-bblocks)
* Path: `_sources/templates/object-presence`

