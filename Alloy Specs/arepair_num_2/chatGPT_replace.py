import os

import openai
openai.api_key = "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"



i = 0

for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Fix_Replace_Fix/'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.als':

            i +=1
            # a = file
            # print(a)
            print("Analyzed File: " + file)
            file_read = open(file, 'r')
            mylist = file_read.readlines()
            mc = str(mylist)
            file_object = open(file+"_replaced"+'.als', 'a')
            completion = openai.ChatCompletion.create(

                  model="gpt-3.5-turbo",
                  messages=[{"role": "user", "content": "Consider the following Alloy specification and its inline comments. Replace all the lines where the word 'Fix' is found with '//Fix:' and print entire alloy specification " + mc}]
                )


            file_object.write(completion['choices'][0]["message"]["content"])
            #print(completion['choices'][0]["message"]["content"])

#             file_Object.close()










print("Total Analyzed File: " + str(i))
