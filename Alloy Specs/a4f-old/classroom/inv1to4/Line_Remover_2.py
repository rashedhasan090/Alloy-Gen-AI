import os

i = 0
for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/a4f/classroom/inv1to4_copy_2'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.sql':

            i +=1

            print("Analyzed File: " + file)
            file_read = open(file, 'r')
            lines = file_read.readlines()
            # mc = str(mylist)
            # file_object = open( 'a')

            with open(file+"_correct_removed"+'.txt','w') as file:
                for line in lines:
                    # find() returns -1 if no match is found
                    if line.find("--correct") != -1:
                        pass
                    else:
                        file.write(line)



print("Total Analyzed File: " + str(i))
