# Config Builder

This is a custom DSL for WireBox that will return whatever configuration information exists at the path specified.

## Requirements

- Lucee 5+
- ColdBox 4+

## Installation

Install using [CommandBox](https://www.ortussolutions.com/products/commandbox):
`box install config-builder`

The module will configure itself and register a DSL when the ColdBox application starts.

## Usage

Consider the following chunk of config.Coldbox \[sic\]:
```
    variables.settings = {
        search = {
            published = {
                solr_host = "supercluster.ecivis.com:8993",
                solr_core = "pure_gold"
            },
            incoming = {
                solr_host = "aggregator.ecivis.com:8995",
                solr_core = "raw_ore"
            }
        },
        auth = {
            tokens = {
                test = ["foo", "bar"],
                prod = ["secret", "monkey"]
            }
        }
    }
```

To inject a specific search configuration structure, use this type of injection with any component that is instantiated by WireBox:
```
    property name="publishedSearch" inject="config:search.published";
```

To inject a specific nested value:
```
    property name="prodTokens" inject="config:auth.tokens.prod";
```

A possible future enhancement would be to support an injection like this:
```
    property name="prodToken" inject="config:auth.tokens.prod[1]";
```

## License

See the [LICENSE](LICENSE.txt) file for license rights and limitations (MIT).
