import sys
import os
from os import listdir

test=os.listdir("/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_without_bug_location")

for item in test:
    # if item.endswith(".sql"):
    #     os.remove(item)
    # if item.endswith(".xml"):
    #     os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    # if item.endswith(".als"):
    #     os.remove(item)
    if item.endswith(".nofix.alsresults.als"):
        os.remove(item)
    if item.endswith(".txt_fix_removed.als"):
        os.remove(item)
