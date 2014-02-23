#!/usr/bin/python

import sys
import re
import gzip

dbpedia_file = '../data/mappingbased_properties_en.ttl.gz'

f = gzip.open(dbpedia_file, 'rb') 
r = re.compile(r'(?:[^ "]|"[^"]*")+')   # split string based on space outside quotes
r2 = re.compile(r'/[^/>]*\>$')   # extract string inside <...>
r3 = re.compile(r'"[^"]*"')   # extract string inside "..."

entMap = {}
relMap = {}

relTable = []
attTable = []

def add(dict, value):
  if not dict.has_key(value):
    ret = len(dict)
    dict[value] = ret
    return ret
  else:
    return dict[value]

# write a dictionary as a comma-separated csv
def dumpDict(dict, fileName):
  of = open(fileName, 'w')
  for key, value in dict.items():
    of.write(str(value)+',"'+key+'"\n')
  of.close()

# write tuples as a comma-separated csv
def dumpTable(table, fileName):
  of = open(fileName, 'w')
  for t in table:
    tup = [str(x) for x in t]
    tup[-1] = '"'+tup[-1]+'"'
    of.write(','.join(tup)+'\n')
  of.close()

ln = 0; N = 25910645; p = 0
for line in f:
  if line[0] != '#':
    try:
      (sub, prop, obj) = r.findall(line.strip())[:3]
      sub = add(entMap, r2.search(sub).group()[1:-1])
      prop = add(relMap, r2.search(prop).group()[1:-1])
      if '"' not in obj:  # object property
        obj = add(entMap, r2.search(obj).group()[1:-1])
        relTable.append((sub, prop, obj))
      else:               # data property
        obj = r3.search(obj).group()[1:-1]  
        attTable.append((sub, prop, obj))
    except:
      print >> sys.stderr, 'Warning: Line %d syntax error: %s' % (ln+1, line)
  ln += 1
  if ln*100/N > p:
    p = ln*100/N
    print '%d%% complete.' % p

dumpDict(entMap, '../csv/entities.csv')
dumpDict(relMap, '../csv/relations.csv')
dumpTable(relTable, '../csv/relationships.csv')
dumpTable(attTable, '../csv/attributes.csv')

f.close()
