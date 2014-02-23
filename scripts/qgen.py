#!/usr/bin/python

import random

r = range(0, 2607952)
#for N in range(1, 3000020, 3000020/20):
N=1000
of = open('q'+str(N)+'.csv', 'w')
nodes = random.sample(r, N)
for n in nodes:
  of.write(str(n)+','+str(1.0/N)+'\n')
of.close()
