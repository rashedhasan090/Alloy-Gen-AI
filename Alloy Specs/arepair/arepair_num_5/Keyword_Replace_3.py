import os
import sys, string

i = 0
search_text = "Fix"
replace_text = "Fix"

for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Fix_Replace_Fix'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.als':
            i +=1
        

            with open(file, 'r') as file:

                data = file.read()

                data = data.replace(search_text, replace_text)

            with open(r'SampleFile.txt', 'w') as file:
                file.write(data)




# for  x in range(len(mylist)) :
#
#     file_object.write((mylist[x]))
#     x += 1




print("Total Analyzed File: " + str(i))
