import os

i = 0
for root, dirs, files in os.walk(r'/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3'):
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

            with open(file+"char_removed"+'.sql','w') as file:
                for line in lines:
                    # find() returns -1 if no match is found
                    if line.find("--incorrect") != -1:
                        pass
                    else:
                        file.write(line)



print("Total Analyzed File: " + str(i))
