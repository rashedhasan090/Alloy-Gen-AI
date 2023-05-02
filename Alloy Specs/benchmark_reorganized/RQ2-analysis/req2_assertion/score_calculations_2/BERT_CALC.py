import os
import nltk
from sentence_transformers import SentenceTransformer, util

# Function to extract the line after the line containing "Bug"
def extract_next_line_with_bug(file_path):
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            if 'Bug' in line:
                next_line = lines[i + 1].strip()
                return next_line
    return None

# Function to calculate BERT-based similarity score between two sentences
def calculate_bert_similarity(reference, hypothesis):
    # Load the pre-trained BERT model
    model = SentenceTransformer('bert-base-uncased')

    # Encode the reference and hypothesis sentences
    reference_embedding = model.encode([reference])
    hypothesis_embedding = model.encode([hypothesis])

    # Calculate the cosine similarity between the embeddings
    similarity_score = util.pytorch_cos_sim(reference_embedding, hypothesis_embedding)[0][0].item()

    return similarity_score

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
                bert_similarity = calculate_bert_similarity(source_line_with_bug, dest_line_with_bug)

                if dest_folder in similarity_scores:
                    similarity_scores[dest_folder].append(bert_similarity)
                else:
                    similarity_scores[dest_folder] = [bert_similarity]

# Calculate average similarity scores for each destination folder
average_scores = {}
for dest_folder, scores in similarity_scores.items():
    average_scores[dest_folder] = sum(scores) / len(scores)

# Calculate overall average similarity score
overall_average_score = sum(average_scores.values()) / len(average_scores)

# Save similarity scores to a text file
output_file = 'BERT_scores.txt'
with open(output_file, 'w') as file:
    file.write(f"Overall Average Score: {overall_average_score}\n\n")
    for dest_folder, score in average_scores.items():
        file.write(f"{dest_folder}: {score}\n")
