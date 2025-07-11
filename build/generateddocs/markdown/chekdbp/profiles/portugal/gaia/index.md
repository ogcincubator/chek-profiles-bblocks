
# Vila Nova de Gaia profile (Model)

`ogc.chekdbp.profiles.portugal.gaia` *v1.0*

Profile for the Vila Nova de Gaia (PT) municipality

[*Status*](http://www.opengis.net/def/status): Stable

## Description

This profile checks that:

* A building of interest exists.
* All buildings fulfill the following criteria:
  * Roofs are present with LoD 2 and up.
  * Walls are preent with LoD 3.1 and up.
  * There is an attribute `hasWindows` set to `true`.
  
Additionally, rules from the `roads-present` and `green-public-spaces-present` profiles.

The following UML diagram illustrates all the validation classes and attributes:

![Gaia UML diagram](assets/gaia-uml.png)


# For developers

The source code for this Building Block can be found in the following repository:

* URL: [https://github.com/ogcincubator/chek-profiles-bblocks](https://github.com/ogcincubator/chek-profiles-bblocks)
* Path: `_sources/profiles/portugal/gaia`

