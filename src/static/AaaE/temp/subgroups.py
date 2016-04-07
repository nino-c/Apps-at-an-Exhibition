#
# Invoke with an integer as the first argument to the script.
# Subgroup diagram of the group consisting of the integers mod (n) will result
#

import math
from sets import Set
import numpy as np
from visual import *


div420 = []
for i in range(210):
    if 420 % (i+1) == 0:
        div420.append(i+1)

#print div420

subgroups = []
for d in div420:
    row = [d]
    for div in div420:
        if div > d and div % d == 0:
            row.append(div)
    subgroups.append(row)


def get_div(n):
    div = []
    for i in range(1,n):
        if n % i == 0:
            div.append(i)
    return div


def is_prime(n):
    if n==1:
        return False
    for i in range(2, n):
        if n % i == 0:
            return False
    return True

def ensure_rel_prime(row):
    newrow = Set()
    comprow = []
    for e1 in row:
        add = True
        for c in comprow:
            if e1 % c == 0:
                add = False
        comprow.append(e1)
        if add:
            newrow.add(e1)


    ls = list(newrow)
    ls.sort()
    return ls

def subgroups(n):
    rows = [[1]]
    row = []
    for i in range(1,int(math.floor(n/2))):
        if n % i == 0 and is_prime(i):
            row.append(i)
    rows.append(row)

    div = get_div(n)
    print "div", div

    def check_membership(x):
        if x == n:
            return False
        for r in rows:
            for element in r:
                if element == x:
                    return True
        return False

    while True:
        newrow = []
        # all product combinations of current previous rows
        # up to itself

        for element in rows[-1]:
            for prevrow_index in range(1, len(rows)):
                prevrow = rows[prevrow_index]
                for e2 in prevrow:
                    m = element * e2
                    if len(newrow) > 0 and m == n:
                        continue
                    if n % m == 0 and not check_membership(m) and not m in newrow:
                        for ne in newrow:
                            if ne > m and ne % m == 0:
                                continue
                        #print n, m, n/m
                        newrow.append(m)

        newrow_relprime = newrow #ensure_rel_prime(newrow)
        newrow_relprime.sort()
        rows.append(newrow_relprime)
        if len(rows)>10:
            break

    return rows



S = subgroups(420)
#for row in S:
#    print row





scene2 = display(title='Group Z(n)', x=0, y=0, width=1200, \
    height=800, center=(600,300))

position = dict()

for y, row in enumerate(S):
    if len(row) == 0:
        continue

    row_y = 20 + y*120
    row_x_unit = 1200. / len(row)
    if len(row) == 1:
        row_x_unit = 600
    elements = []
    for x, item in enumerate(row):
        x_pos = 0
        if len(row) == 1:
            x_pos = 600
        else:
            x_pos = row_x_unit*x
            x_pos += (float(row_x_unit)/2.)
        label(pos=(x_pos,row_y), text=str(item))
        xy = [x_pos, row_y]
        position[str(item)] = xy


n = int(sys.argv[1])
for div in get_div(n):
    #find first appearance
    for i, row in enumerate(S):
        for element in row:
            if div == element:
                if len(S) > i+1:
                    nextrow = S[i+1]
                    factors = []
                    for j in nextrow:
                        if j % div == 0:
                            factors.append(j)
                            curve(pos=[position[str(element)], position[str(j)]])
                print div, ": ", factors