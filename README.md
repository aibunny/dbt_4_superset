# **Setup**

1. When setting up the project create a virtulenv by running on terminal

```bash
virtualenv dbt
```

activate the enviroment

```bash
source ./db/bin/activate
```

clone this project using git to your target dir

Install the project requirements

```bash
pip install -r requirements.txt
```

2. Create a `profiles.yml` file in your current dir then paste one of the profiles in [sample.profiles.yml](./sample.profiles.yml) , edit the details as required the `smartcollect_pg` is for psql and `smartcollect_ch` is for clickhouse
3. Edit [dbt_project.yml](./dbt_project.yml) and change the `profile` to match your intended target database as defined above in `profiles.yaml`
   NB: The default profile is for postgres only edit if using clickhouse or if you changed the profile names in step 2

# Running

Running the dbt project require passing either of the following vars since our stacks are both clickhouse and psql, when your

source db is Postgresql use:

```bash
 dbt run --vars "{'source_db':'smartcollect_pg'}" --profile-dir .
```

else when the source db is clickhouse use:

```bash
dbt run --vars "{'source_db':'smartcollect_ch'}" --profile-dir .
```

### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
