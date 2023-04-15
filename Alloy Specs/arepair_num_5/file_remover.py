import sys
import os
from os import listdir




test=os.listdir("/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_5/")

for item in test:
    # if item.endswith(".sql"):
    #     os.remove(item)
    # if item.endswith(".xml"):
    #     os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    if item.endswith(".als_result.als"):
        os.remove(item)
