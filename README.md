Try running the following commands:

- dbt run
- dbt test

### Staging

 All models here are just materialized views replicas of data in the sc db

For domuentation use `dbt_docstring <project root dir>` as shown here [dbt docstring](https://github.com/anelendata/dbt_docstring)

#### Metrics Format

```
meta:
      superset_metrics:
        - name: Total Files #Name must be uniques
          label: Total Files
          expression: COUNT(id) ##ALL expressions should be in uppercase and correct sql syntax
          type: count
	  description: Total files
```
