

import os
i = 0
for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Fix_Replace_Fix/'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.als':
            i +=1
            # a = file
            # print(a)
            print(file)
            file_read = open(file, 'r')
            mylist = file_read.readlines()
            mylist = str(mylist,"\n")
            var1 = "Fix"
            var2 = "fix"
            var3 = "//Bug:"


            # var4 = "Fix"

            # fp = open(file+'_replace.als', 'a')

            with open(file+'_replace.als', 'w') as fp:
                for item in mylist:

                    if f'{var1}' in mylist[j]:
                        mylist[j] = (f"{var3}")
                        a1 = mylist[j]
                        fp.write(a1)
                        fp.write("\n")


                    if f'{var2}' in mylist[j]:
                        mylist[j] = (f"{var3}")
                        a2 = mylist[j]
                        fp.write(a2)
                        fp.write("\n")
                    # write each item on a new line
                    fp.write("%s\n" % item)
                print('Done')



print(i)



            # for  x in range(len(mylist)) :
            #
            #     j = print(mylist[x])
            #     x += 1
            #     fp.append(j)


                    # for  x in range(len(mylist)) :







# fp.write(j)
# fp.write("\n")
