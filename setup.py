import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name='smartcollect-lineage',
    version='0.1.0',
    author='AIBUNNY',
    author_email='analytics@crafted.co.ke',
    description="Allows automation between superset and dbt",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url='https://github.com/aibunny/dbt-4-superset',
    project_urls={
        "Bug Tracker": "https://github.com/aibunny/dbt-4-superset/issues"
    },
    license='MIT',
    packages=['toolbox'],
    install_requires=['requests'],
    entry_points={
        'console_scripts': [
            'smartcollect-lineage = smartcollect_lineage.__init__:app',
        ],
    },
)
