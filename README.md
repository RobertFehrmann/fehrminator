# Fehrminator

## Specification

Fehrminator is a data generation framework to generate testing data based on a given schema at scale.

The framework takes the following input schema
1. Schema name
1. Table name
1. Column name
1. Column cardinality
1. Table cardinality
1. Data type
1. Data length
1. Data precision

Using the input schema, the framework generates an SQL script to generate data in Snowflake. The SQL script can be generated using the Excel workwork or the python Script.

## Excel Code Generation

1. Request the schema information from the customer
1. Cleanse the schema information, in particular check the data types
1. Copy the customer data onto the formula worksheet
1. Save the worksheet as txt format
1. Run the following command to generate the SQL Script

cat name.txt | sed "s/\"//g" | sed "s/\|/\"/g" | awk -F"\t" -f assemble.awk

## Python Code Generation

1. Request the schema information from the customer
1. Cleanse the schema information, in particular check the data types
1. Save the worksheet as csv format
1. Run the following command to generate the SQL Script

python snowflake_python_generator.py name.csv


