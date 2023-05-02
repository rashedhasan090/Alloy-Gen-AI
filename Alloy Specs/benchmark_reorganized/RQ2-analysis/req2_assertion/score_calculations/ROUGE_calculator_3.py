import os
import nltk

from nltk.translate.bleu_score import sentence_bleu
from rouge import Rouge

# Function to extract the line after the line containing "Bug"
def extract_next_line_with_bug(file_path):
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            if 'Bug' in line:
                next_line = lines[i + 1].strip()
                return next_line
    return None

# Function to calculate ROUGE-L score between two sentences
def calculate_rouge_l_score(reference, hypothesis):
    if reference and hypothesis:
        rouge = Rouge()
        scores = rouge.get_scores(hypothesis, reference)
        rouge_l_score = scores[0]['rouge-l']['f']
        return rouge_l_score
    else:
        return 0

source_folder = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/original files (assertion)'
destination_folders = ['/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_1',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_2',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_3',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_4',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_5',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_6',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_7',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_8',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_9',
                       '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations/Test_Run_10']

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
                rouge_l_score = calculate_rouge_l_score(source_line_with_bug, dest_line_with_bug)

                if dest_folder in similarity_scores:
                    similarity_scores[dest_folder].append(rouge_l_score)
                else:
                    similarity_scores[dest_folder] = [rouge_l_score]

# Calculate average similarity scores for each destination folder
average_scores = {}
for dest_folder, scores in similarity_scores.items():
    average_scores[dest_folder] = sum(scores) / len(scores)

# Calculate overall average similarity score
overall_average_score = sum(average_scores.values()) / len(average_scores)

# Save similarity scores to a text file
output_file = 'similarity_scores.txt'
with open(output_file, 'w') as file:
    file.write(f"Overall Average Score: {overall_average_score}\n\n")
    for dest_folder, score in average_scores.items():
        file.write(f"{dest_folder}: {score}\n")
