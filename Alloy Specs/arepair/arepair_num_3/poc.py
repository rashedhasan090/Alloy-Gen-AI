import os
import openai
openai.api_key = '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'
messages = [ {"role": "system", "content":
              "You are a intelligent assistant."} ]
i = 0
for root, dirs, files in os.walk('/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair/'):
    for file in files:
        #each file

        filename, extension = os.path.splitext(file)
        if extension == '.txt':

            i +=1
            # a = file
            # print(a)
            print(file)
            file_read = open(file, 'r')
            mylist = file_read.readlines()

            file_object = open(file+"result"+'.txt', 'a')

            while True:
                message = ("Consider the following Alloy specification and its inline comments. There is a bug in this specification. Please find the bug and fix it. \n" + str(mylist))
                if message:
                    messages.append(
                        {"role": "user", "content": message},
                    )
                    chat = openai.ChatCompletion.create(
                        model="gpt-3.5-turbo", messages=messages
                    )
                reply = chat.choices[0].message.content
                print(f"ChatGPT: {reply}")
                messages.append({"role": "assistant", "content": reply})
                file_object.write(str(messages))
                file_object.write("\n")
file_object.close()
print(i)
