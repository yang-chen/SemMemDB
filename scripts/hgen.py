#!/usr/bin/python

import math
import random

T = 10

fin = open('../csv/counts.csv', 'r')
fout = open('../csv/history.csv', 'w')
for line in fin:
  (node, cnt) = line.strip().split(',')
  node = int(node)
  cnt = int(cnt)
  lambd = -1.8 + 4.0/(1.0+math.exp(-cnt/20000.0))
  t = 0
  while t < T:
    fout.write(str(node)+','+str(t)+'\n')
    t += random.expovariate(lambd)

fin.close()
fout.close()
