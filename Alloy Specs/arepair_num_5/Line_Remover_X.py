import os
import re

i = 0
for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Fix_Replace_Fix'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.als':

            i +=1

            print("Analyzed File: " + file)
            file_read = open(file, 'r')
            lines = file_read.readlines()
            file_object = open(file+'_rm.txt', 'a')
            lnx = str(lines)
            lnx=re.sub(f"Fix.*$", "Fix", lines)
            for x in items:
                file.write(lines)

            # # mc = str(mylist)
            # # file_object = open( 'a')
            #
            # # with open(file+"_Fix_removed"+'.als','w') as file:
            # #     for line in lines:
            # #         line.replace("Fix","Fix")
            # #         file.write(line)
            #
            # find() returns -1 if no match is found
            # if line.find("Fix"):
            #     line.replace("Fix","Fix")
            #
            #     # lines.add("Fix")
            #
            #     pass
            # else:
            #     file.write(line)

print("Total Analyzed File: " + str(i))
