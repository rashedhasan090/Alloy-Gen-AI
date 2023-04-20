import sys
import os
from os import listdir




test=os.listdir("/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_3")

for item in test:
    if item.endswith(".txt"):
        os.remove(item)
    # if item.endswith(".xml"):
    #     os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    # if item.endswith(".alsresult.als"):
    #     os.remove(item)
    # if item.endswith(".als"):
    #     os.remove(item)
