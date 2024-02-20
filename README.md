# dbt-4-superset

Installation

```
pip install dbt-superset-lineage
```

## Usage

`dbt-superset-lineage` comes with a few basic commands: `pull-dashboards` , `push-metrics` and `push-descriptions `. The documentation for the individual commands can be shown by using the `--help` option.

It includes a wrapper for [Superset API](https://superset.apache.org/docs/rest-api), one only needs to provide
`SUPERSET_ACCESS_TOKEN`/`SUPERSET_REFRESH_TOKEN` (obtained via `/security/login`)
as environment variable or through `--superset-access-token`/`superset-refresh-token` option.

**N.B.**

- Make sure to run `dbt compile` (or `dbt run`) against the production profile, not your development profile
- In case more databases are used within dbt and/or Superset and there are duplicate names (`schema + table`) across
  them, specify the database through `--dbt-db-name` and/or `--superset-db-id` options
- Currently, `PUT` requests are only supported if CSRF tokens are disabled in Superset (`WTF_CSRF_ENABLED=False`).
- Tested on dbt v1.4.5 and Apache Superset v2.0.1. Other versions might face errors due to different underlying code and API.

### Pull dashboards

Pull dashboards from Superset and add them as
[exposures](https://docs.getdbt.com/docs/building-a-dbt-project/exposures/) to dbt docs with
references to dbt sources and models, making them visible both separately and as dependencies.

**N.B.**

- Only published dashboards are extracted.

```console
$ cd jaffle_shop
$ dbt compile  # Compile project to create manifest.json
$ export SUPERSET_ACCESS_TOKEN=<TOKEN>
$ dbt-superset-lineage pull-dashboards https://mysuperset.mycompany.com  # Pull dashboards from Superset to /models/exposures/superset_dashboards.yml
$ dbt docs generate # Generate dbt docs
$ dbt docs serve # Serve dbt docs
```

![Separate exposure in dbt docs](assets/exposures_1.png)

![Referenced exposure in dbt docs](assets/exposures_2.png)

### Push descriptions

Push model and column descriptions from your dbt docs to Superset as plain text so that they could be viewed
in Superset when creating charts.

**N.B.**:

- Run carefully as this rewrites your datasets using merged metadata from Superset and dbt docs.
- Running with `--superset-refresh-columns` overrides `columns.filterable` and `columns.groupby` to `true`,
  because of [this issue](https://github.com/apache/superset/issues/24136).
- Descriptions are rendered as plain text, hence no markdown syntax, incl. links, will be displayed.
- Avoid special characters and strings in your dbt docs, e.g. `→` or `<null>`.

```console
$ cd jaffle_shop
$ dbt compile  # Compile project to create manifest.json
$ export SUPERSET_ACCESS_TOKEN=<TOKEN>
$ dbt-superset-lineage push-descriptions https://mysuperset.mycompany.com  # Push descrptions from dbt docs to Superset
```

![Column descriptions in Superset](assets/descriptions.png)

## License

Licensed under the MIT license (see [LICENSE.md](LICENSE.md) file for more details).
