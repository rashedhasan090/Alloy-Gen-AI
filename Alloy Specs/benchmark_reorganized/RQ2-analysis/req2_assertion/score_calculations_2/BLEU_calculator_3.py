import os
import nltk

from nltk.translate.bleu_score import sentence_bleu

# Function to extract the line after the line containing "Bug"
def extract_next_line_with_bug(file_path):
    with open(file_path, 'r', encoding='latin-1') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            if 'Bug' in line:
                next_line = lines[i + 1].strip()
                return next_line
    return None

# Function to calculate BLEU score between two sentences
def calculate_bleu_score(reference, hypothesis):
    reference_tokens = nltk.word_tokenize(reference)
    hypothesis_tokens = nltk.word_tokenize(hypothesis)
    return sentence_bleu([reference_tokens], hypothesis_tokens)

source_folder = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/original files'
destination_folders = ['/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 1',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 2',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 3',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 4',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 5',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 6',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 7',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 8',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 9',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 10']

# Dictionary to store similarity scores for each destination folder
similarity_scores = {}

# Iterate through each file in the source folder
for source_file in os.listdir(source_folder):
    source_file_path = os.path.join(source_folder, source_file)
    source_line_with_bug = extract_next_line_with_bug(source_file_path)

    if source_line_with_bug is None:
        continue

    # Iterate through each destination folder
    for dest_folder in destination_folders:
        dest_file_path = os.path.join(dest_folder, source_file)

        if os.path.exists(dest_file_path):
            dest_line_with_bug = extract_next_line_with_bug(dest_file_path)

            if dest_line_with_bug is not None:
                bleu_score = calculate_bleu_score(source_line_with_bug, dest_line_with_bug)

                if dest_folder in similarity_scores:
                    similarity_scores[dest_folder].append(bleu_score)
                else:
                    similarity_scores[dest_folder] = [bleu_score]

# Calculate average similarity scores for each destination folder
average_scores = {}
for dest_folder, scores in similarity_scores.items():
    average_scores[dest_folder] = sum(scores) / len(scores)

# Calculate overall average similarity score
overall_average_score = sum(average_scores.values()) / len(average_scores)

# Display individual scores and average score
for dest_folder, score in average_scores.items():
    print(f'{dest_folder}: {score}')

print(f'Overall Average Score: {overall_average_score}')

# Save average similarity scores to a text file
output_file = 'BLEU_scores.txt'
with open(output_file, 'w') as file:
    for dest_folder, score in average_scores.items():
        file.write(f'{dest_folder}: {score}\n')
    file.write(f'Overall Average Score: {overall_average_score}\n')
