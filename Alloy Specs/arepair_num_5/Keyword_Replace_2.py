import os
import sys, string

i = 0
for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Fix_Replace_Fix'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.als':


            i +=1

            print("Analyzed File: " + file)

            file_read = open(file, 'r')
            mylist = file_read.readlines()
            mystr = str(mylist)

            file_object = open(file+'Fix1.als', 'a')
            Rep1 = mystr.replace("Fix", "Fix")
            for  x in range(len(Rep1)) :

                Rep1[x]
                x += 1
            file_object.write(Rep1)
            file_object.write("\n")

            # with open(file+'_rep_Fix_w_Fix.als', 'a') as file:
            #
            #
            #

                # file.write(str(lines))

                # for line in lines:
                #     line.replace("Fix", "Fix")
                #     # line.replace ("Fix","Fix")
                #     file.write(line)
                    # find() returns -1 if no match is found


print("Total Analyzed File: " + str(i))
