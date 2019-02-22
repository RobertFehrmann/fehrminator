#!/usr/bin/env python

# Based on Robert Fehrmann's Data Generation process.
# Program loads the file providing the input and generates the required execution scripts.
# 2019-01-08  jfrink    Initial Creation
#
#  Version 1.0.0
#
#  -> ./snowflake_datagen.py demoxx load_wh peter -db SALES

import sys
import os, glob, errno
import getpass
import argparse
#import snowflake.connector
import re
import csv

#Verbose processing
def show_verbose(verbose, text_to_print):
  if verbose:
    print(text_to_print)
  return


#run_sql to pass result set back
def run_sql(conn, sql, fetchall):
  cur = conn.cursor()
  try:
    cur.execute(sql)
    if fetchall:
      res=cur.fetchall()
    else:
      res = cur.fetchone()

  except (snowflake.connector.errors.ProgrammingError) as e:
    print("Statement error: {0}".format(e.msg))
  except:
    print("Unexpected error: {0}".format(e.msg))

  finally:
    cur.close()
  return res

def load_db_file(filename,quoted_names):

  database_objects = {}
  seed_1 = 10000  #default seed value, increaments for each row added
  if (quoted_names):
    quotes='"'
  else:
    quotes=''

  """try:
   fh = open(filename, 'rU')
  except IOError:
    print("Could not open file! " + filename)"""

  #Used to skip the header record in the file.
  with open(filename, 'rU') as fh:
    next(fh)
    for line_list in csv.reader(fh, delimiter=',', quotechar='"'):
      db="TEST"
      schema=line_list[0]
      tbl=quotes + line_list[1] + quotes
      col=quotes + line_list[2] + quotes
      cardinality=line_list[3].strip()
      tbl_cardinality=line_list[4].strip()
      datatype=line_list[5]
      datatype_length=line_list[6].strip()
      datatype_precision=line_list[7].strip()
      if(len(line_list)>7):
        null_values=line_list[8].strip()
        if (null_values==''):
           null_ratio=0
        else:
           null_ratio=(float(null_values)/float(tbl_cardinality))*1000

      seed_1=seed_1+1

      #Reset the formula to make sure we catch all occurances
      formula = ''

      if datatype.upper() == 'DATE':
        fb = 'dateadd(day, uniform(1, ' + str(cardinality) + ', random('+ str(seed_1) +')), date_trunc(day, current_date))'
        fe = '::date as ' + col
      elif datatype.upper() == 'TIMESTAMP':
        fb = '(date_part(epoch_second, current_date) + (uniform(1, ' + str(cardinality) + ', random('+ str(seed_1) +'))))'
        fe = '::timestamp as ' + col
      elif datatype.upper() == 'CHAR':
        fb = 'rpad(uniform(1, ' + str(cardinality) + ', random(' + str(seed_1) + '))::varchar,'+ str(datatype_length) + ", 'abcdefghifklmnopqrstuvwxyz')"
        fe = '::char(' + str(datatype_length) + ') as ' + col
      elif datatype.upper() == 'VARCHAR':
        fb = 'rpad(uniform(1, ' + str(cardinality) + ', random(' + str(seed_1) + '))::varchar,uniform(length(' +  str(cardinality) + '),' +str(datatype_length) + ',random(' + str(seed_1+20000) + '))' + ", 'abcdefghifklmnopqrstuvwxyz')" 
        fe = '::varchar(' + str(datatype_length) + ') as ' + col
      elif datatype.upper() == 'BIGINT' or datatype.upper() == 'INTEGER' or datatype.upper() == 'DOUBLE' or datatype.upper() == 'FLOAT':
        fb = 'uniform(1,' + str(cardinality) + ' , random('+ str(seed_1) +'))'
        fe = '::' + datatype.lower() + ' as ' + col
      elif datatype.upper() == 'NUMBER':
        fb = 'uniform(1,' + str(cardinality) + ' , random('+ str(seed_1) +'))'
        fe = '::number(' + str(datatype_length) + ',' + str(datatype_precision) + ') as ' + col
      else:
        fb=''
        fe=''

      if (fb==''):
        print( "Unknown Datatype: ",datatype ) 
      else:
        if (int(cardinality)<=0):
          formula = 'null'+fe
        elif (null_ratio<=0):
          formula = fb + fe
        else:
          formula = '(case when uniform(1,1000,random(20011))<='+str(int(null_ratio))+' then null else '+fb+' end)'+fe

        column_info={'NAME': col, 'DATA_TYPE': datatype, 'LENGTH': datatype_length, 'CARDINALITY': cardinality, 'TBL_CARDINALITY': tbl_cardinality, 'FORMULA': formula  }

        if db not in database_objects:
          database_objects[db] = {}

        schema_objects=database_objects[db]

        if schema not in schema_objects:
          schema_objects[schema] = {}

        tbl_objects=schema_objects[schema]

        if tbl not in tbl_objects:
          tbl_objects[tbl] = []

        tbl_objects[tbl].append(column_info)

  fh.close()

  return database_objects



def print_ddl(database_objects, outputfile):

  if outputfile:
    try:
      of = open(outputfile, 'w')
    except IOError:
      print("Could not open file! " + outputfile)
  else:
    of = ''

  for db in sorted(database_objects.keys()):    #Database Name
    #Now loop through the new obj_hash to print out the ddl
    printer('-------------------------------------', of)
    printer('-- Generating Database: ' + str(db), of)
    printer('-------------------------------------', of)
    schema_obj=database_objects[db]
    for schema in schema_obj:
      printer('CREATE TRANSIENT SCHEMA IF NOT EXISTS ' + str(schema) + ' DATA_RETENTION_TIME_IN_DAYS=0;', of)
      printer('USE SCHEMA '+ str(schema) +';', of)
      tbl_obj=schema_obj[schema]
      for tbl in tbl_obj:
        printer('CREATE or REPLACE TABLE '+ tbl, of)
        printer('AS', of)
        printer('SELECT', of)
        col_obj=tbl_obj[tbl]
        num_of_columns=len(col_obj)
        counter=1
        for col in col_obj:
          if counter < num_of_columns:
            printer('   ' + col['FORMULA'] + ',', of)
            counter=counter+1
          else:
            printer('   ' + col['FORMULA'], of)
            printer('from table(generator(rowcount => ' + str(col['TBL_CARDINALITY']) + '));' , of)
            printer(' ', of)

  if of != '':
    if not of.closed:
      of.close()

  return

def printer(text, fh):


  if fh =='':
    print(text)
  else:
    if not fh.closed:
      fh.write(text+"\n")
  return


def main():
  ##### MAIN #####
  parser = argparse.ArgumentParser(description='Snowflake Data Generation Utility.',
          epilog='Example: snowflake_datagen.py source_file.csv')
  parser.add_argument('filename', action='store',
        help='Customer Sample file template')
  parser.add_argument('-sqlfile', '--sqlfile', action='store',
        help='Create an output file script containing the create role ddl and grants, to be used with -ddl switch')
  parser.add_argument('-q', '--quoted_names', action='store_true',
        help='Enclose name with double quotes')
  parser.add_argument('-v', '--verbose', action='store_true', help='verbose')

  args=parser.parse_args();
  if args.verbose:
    print("filename=" + str(args.filename))       # File to be loaded
    print("sqlfile=" + str(args.sqlfile))  # show debugging output
    print("verbose=" + str(args.verbose))  # show debugging output

  db_objects=load_db_file(args.filename,args.quoted_names)

  print_ddl(db_objects, args.sqlfile)

  return

if __name__ == "__main__":
  main()
