import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name = 'dbt-4-superset',
    version='0.1.0',
    author='AIBUNNY',
    author_email='fred@crafted.co.ke',
    description="Allows automation between superset and dbt",
    long_description=long_description,
    long_description_content_type = "text/markdown",
    url='https://github.com/aibunny/dbt-4-superset',
    project_urls = {
        "Bug Tracker": "https://github.com/aibunny/dbt-4-superset/issues"
    },
    license='MIT',
    packages=['toolbox'],
    install_requires=['requests'],
)