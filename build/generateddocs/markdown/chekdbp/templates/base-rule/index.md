
# Base rule template (Schema)

`ogc.chekdbp.templates.base-rule` *v0.1*

Supporting building block with common rule template properties

[*Status*](http://www.opengis.net/def/status): Under development

## Schema

```yaml
$schema: https://json-schema.org/draft/2020-12/schema
type: object
required:
- id
properties:
  id:
    description: Identifier for this rule, a URI preferably
    type: string
    x-jsonld-id: '@id'
  title:
    description: Title for this rule
    type: string
  description:
    description: Textual description for this rule
    type: string
    x-jsonld-id: http://www.w3.org/ns/shacl#description
  message:
    description: Message returned by the SHACL validator
    type: string
    x-jsonld-id: http://www.w3.org/ns/shacl#message
x-jsonld-extra-terms:
  label: http://www.w3.org/ns/shacl#name
x-jsonld-base: http://example.com/change-me/
x-jsonld-prefixes:
  sh: http://www.w3.org/ns/shacl#
  my-rule: http://example.com/change-me/
  rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
  rdfs: http://www.w3.org/2000/01/rdf-schema#
  dct: http://purl.org/dc/terms/
  xsd: http://www.w3.org/2001/XMLSchema#
  owl: http://www.w3.org/2002/07/owl#
  city: http://example.com/vocab/city/
  attr: http://example.com/vocab/city/attr#
  sd: https://w3id.org/okn/o/sd#
  chek: urn:chek:vocab/

```

Links to the schema:

* YAML version: [schema.yaml](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/base-rule/schema.json)
* JSON version: [schema.json](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/base-rule/schema.yaml)


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
[context.jsonld](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/base-rule/context.jsonld)


# For developers

The source code for this Building Block can be found in the following repository:

* URL: [https://github.com/ogcincubator/chek-profiles-bblocks](https://github.com/ogcincubator/chek-profiles-bblocks)
* Path: `_sources/templates/base-rule`

