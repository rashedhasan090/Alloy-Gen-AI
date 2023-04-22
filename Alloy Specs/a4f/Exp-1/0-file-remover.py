import sys
import os
from os import listdir




test=os.listdir("/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-1")

for item in test:
    # if item.endswith(".sql"):
    #     os.remove(item)
    if item.endswith(".txt"):
        os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    # if item.endswith(".txt"):
    #     os.remove(item)
