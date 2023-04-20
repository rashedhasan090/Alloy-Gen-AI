import sys
import os
from os import listdir




test=os.listdir("/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Bug_Replace_Fix")

for item in test:
    # if item.endswith(".sql"):
    #     os.remove(item)
    # if item.endswith(".xml"):
    #     os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    if item.endswith(".als_Fix_removed.als"):
        os.remove(item)
