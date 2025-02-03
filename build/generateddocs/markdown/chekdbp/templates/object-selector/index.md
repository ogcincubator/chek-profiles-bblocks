
# Object selector (Schema)

`ogc.chekdbp.templates.object-selector` *v0.1*

Common properties for declaring city object selectors in rule template

[*Status*](http://www.opengis.net/def/status): Under development

## Schema

```yaml
$schema: https://json-schema.org/draft/2020-12/schema
$defs:
  CityObjectId:
    type: string
    enum:
    - OtherConstruction
    - Building
    - BuildingPart
    - BuildingInstallation
    - BuildingConstructiveElement
    - BuildingFurniture
    - BuildingRoom
    - BuildingUnit
    - BuildingStorey
    - CityObjectGroup
    - GenericCityObject
    - Tunnel
    - TunnelPart
    - TunnelInstallation
    - TunnelConstructiveElement
    - TunnelHollowSpace
    - TunnelFurniture
    - Bridge
    - BridgePart
    - BridgeInstallation
    - BridgeConstructiveElement
    - BridgeRoom
    - BridgeFurniture
    - Road
    - Railway
    - TransportSquare
    - Waterway
    - TINRelief
    - WaterBody
    - PlantCover
    - SolitaryVegetationObject
    - LandUse
    - CityFurniture
  CityObjectArray:
    type: array
    items:
      $ref: '#/$defs/CityObjectId'
type: object
oneOf:
- required:
  - path
  properties:
    path:
      description: Array with city object path to desired element, starting from the
        root City Objects
      minItems: 1
      $ref: '#/$defs/CityObjectArray'
- required:
  - idPatterns
  properties:
    idPatterns:
      description: Array with regular expression patterns to filter city objects by
      minItems: 1
      items:
        type: string

```

Links to the schema:

* YAML version: [schema.yaml](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.json)
* JSON version: [schema.json](https://ogcincubator.github.io/chek-profiles-bblocks/build/annotated/chekdbp/templates/object-selector/schema.yaml)


# For developers

The source code for this Building Block can be found in the following repository:

* URL: [https://github.com/ogcincubator/chek-profiles-bblocks](https://github.com/ogcincubator/chek-profiles-bblocks)
* Path: `_sources/templates/object-selector`

