# -*- coding: utf-8 -*-
"""
Created on Wed Feb  6 13:14:48 2019

@author: c1863988
"""

import csv
import numpy as np
import matplotlib.pyplot as plt


i = 0
ncols = 8020
nrows = 7957
minx = 270491
miny = 62521
cellsize = 1
dist_roads = np.zeros([ncols, nrows])
dist_hedgerows = np.zeros([ncols, nrows])

with open('dist_roads.asc') as csvfile:
    csv_reader = csv.reader(csvfile,delimiter = ' ')
    for row in csv_reader:
#        if i == 0: 
#            print(row)
#            ncols = row[1]
#        elif i == 1: 
#            nrows = row[1]
#            R_point = np.zeros([ncols,nrows])
#        elif i == 2:
#            minx = row[1]
#        elif i == 3:
 #           miny = row[1]
#        elif i == 4:
  #          cellsize = row[1]
        if i > 5:
            for n in range(0,ncols):
                dist_roads[n,i-6] = float(row[n])
        i = i + 1
     
#%%
i = 0
with open('dist_man_hed_rf.asc') as csvfile:
    csv_reader = csv.reader(csvfile,delimiter = ' ')
    for row in csv_reader:
        if i > 5:
            for n in range(0,ncols):
                dist_hedgerows[n,i-6] = float(row[n])
        i = i + 1

#%%


extents = [minx, minx + cellsize*ncols, miny, miny + cellsize*nrows]
plt.imshow(dist_roads.T, extent = extents)
plt.show()

#%%
plt.imshow(dist_hedgerows.T)#, origin = 'lower')#,extent = extents)
plt.show()
#%%