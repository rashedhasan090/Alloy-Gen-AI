import os
import openai
import retrying

# Set OpenAI API key
#openai.api_key = "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"
openai.api_key = "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"


# Define retry strategy for internet connection issues
@retrying.retry(wait_fixed=5000)
def call_chat_completion(model, messages):
    return openai.ChatCompletion.create(model=model, messages=messages)

# Load list of already analyzed files
try:
    with open("analyzed_files.txt", "r") as f:
        analyzed_files = f.read().splitlines()
except FileNotFoundError:
    analyzed_files = []

i = 0

# Get current working directory
dir_path = os.getcwd()

for root, dirs, files in os.walk(dir_path):
    for file in files:
        #each file
        filename, extension = os.path.splitext(file)
        if extension == '.als' and file not in analyzed_files:
            i += 1
            file_path = os.path.join(root, file)
            print("Analyzed File: " + file)  # Print only the filename
            with open(file_path, 'r') as f:
                mc = f.read()
            file_object = open(file_path + "result" + '.txt', 'a')

            # Call chat completion API with retry mechanism
            try:
                completion = call_chat_completion("gpt-3.5-turbo", [{"role": "user", "content": "Consider the following Alloy specification and its inline comments. There is a bug in this specification. Please find the bug and fix it. only provide the entire fixed code without any additional explanation. Do not provide partial solutions. \n" + mc}])
                file_object.write(completion['choices'][0]["message"]["content"])
            except retrying.RetryError:
                print("Error: Could not connect to OpenAI API. Skipping file.")
                continue

            analyzed_files.append(file)
            # Write analyzed file to file list
            with open("analyzed_files.txt", "a") as f:
                f.write(file + "\n")

print("Total Analyzed File: " + str(i))
