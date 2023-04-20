import sys
import os
from os import listdir




test=os.listdir("/Users/rashedhasan/Downloads/atmprep-master/benchmark/a4f/classroom/inv1to4")

for item in test:
    # if item.endswith(".sql"):
    #     os.remove(item)
    # if item.endswith(".xml"):
    #     os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    if item.endswith(".txt"):
        os.remove(item)
