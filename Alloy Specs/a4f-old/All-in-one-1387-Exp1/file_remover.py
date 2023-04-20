import sys
import os
from os import listdir




test=os.listdir(r"C:\Users\mhasan6\Downloads\Alloy-Gen-AI-main\Alloy-Gen-AI-main\Alloy-Specs\a4f\All-in-one-1387-Exp1")

for item in test:
    # if item.endswith(".sql"):
    #     os.remove(item)
    if item.endswith(".als"):
        os.remove(item)
    # if item.endswith(".xml.txt"):
    #     os.remove(item)
    # if item.endswith(".txt"):
    #     os.remove(item)
