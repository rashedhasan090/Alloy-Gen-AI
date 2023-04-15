import os
import re

i = 0
for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Bug_Replace_Fix'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.als':

            i +=1

            print("Analyzed File: " + file)
            file_read = open(file, 'r')
            lines = file_read.readlines()
            # mc = str(mylist)
            # file_object = open( 'a')

            with open(file+"_Fix_removed"+'.als','w') as file:
                for line in lines:
                    # find() returns -1 if no match is found
                    line.replace("// Fix:","// Bug:")
                    # res_str = re.sub(r"Fix.$", "//Fix:", line)
                    file.write(line)

print("Total Analyzed File: " + str(i))
