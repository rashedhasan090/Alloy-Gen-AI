import os
import re
import nltk
import numpy as np
import torch
from sklearn.metrics.pairwise import cosine_similarity
from nltk.translate.bleu_score import sentence_bleu, SmoothingFunction
from nltk.translate.meteor_score import meteor_score
from nltk.translate.rouge_score import rouge_score
from transformers import BertTokenizer, BertModel

nltk.download('wordnet')

# Set up the BERT tokenizer and model
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertModel.from_pretrained('bert-base-uncased')
model.eval()

# Function to calculate BERT-based semantic similarity
def calculate_bert_similarity(texts):
    tokenized_texts = [tokenizer.encode(text, add_special_tokens=True) for text in texts]
    max_len = max(len(text) for text in tokenized_texts)
    padded_texts = [text + [0] * (max_len - len(text)) for text in tokenized_texts]
    attention_masks = [[1] * len(text) + [0] * (max_len - len(text)) for text in tokenized_texts]

    input_ids = torch.tensor(padded_texts)
    attention_masks = torch.tensor(attention_masks)

    with torch.no_grad():
        outputs = model(input_ids, attention_mask=attention_masks)
        embeddings = outputs[0][:, 0, :].numpy()

    return cosine_similarity(embeddings)

# Function to find lines in destination files similar to the given line
def find_similar_line(line, destination_files):
    similarities = []
    for file in destination_files:
        with open(file, 'r') as f:
            lines = f.readlines()
            for i, dest_line in enumerate(lines):
                if line in dest_line or line in lines[i-1] or line in lines[i+1]:
                    similarities.append(dest_line)
                    break
    return similarities

# Function to calculate similarity metrics
def calculate_similarity(source_file, destination_files):
    source_lines = []
    with open(source_file, 'r') as f:
        lines = f.readlines()
        for i, line in enumerate(lines):
            if 'Bug' in line:
                source_lines.append(lines[i+1])

    destination_lines = find_similar_line(source_lines[0], destination_files)

    bleu_scores = []
    rouge_scores = []
    meteor_scores = []
    bert_similarities = []

    for dest_line in destination_lines:
        bleu_scores.append(sentence_bleu([source_lines], dest_line, smoothing_function=SmoothingFunction().method1))
        rouge_scores.append(rouge_score.rouge_l([source_lines], [dest_line]))
        meteor_scores.append(meteor_score([source_lines], dest_line))

    bert_similarities = calculate_bert_similarity([source_lines[0]] + destination_lines)

    return np.mean(bleu_scores), np.mean(rouge_scores), np.mean(meteor_scores), np.mean(bert_similarities)

# Function to calculate similarity metrics for all folders
def calculate_folder_similarity(source_folder, destination_folders):
    folder_scores = []
    for folder in destination_folders:
        destination_files = []
        for file in os.listdir(folder):
            if file.endswith('.als'):
                destination_files.append(os.path.join(folder, file))
        if len(destination_files) > 0:
            bleu_score, rouge_score, meteor_score, bert_similarity = calculate_similarity(os.path.join(source_folder, 'Bug.als'), destination_files)
            folder_scores.append((folder, bleu_score, rouge_score, meteor_score, bert_similarity))

    return folder_scores

# Main function
def main():


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

    folder_scores = calculate_folder_similarity(source_folder, destination_folders)

    # Calculate average scores and save to a text file
    average_scores = []
    with open('similarity_scores.txt', 'w') as f:
        for folder_score in folder_scores:
            folder_name, bleu_score, rouge_score, meteor_score, bert_similarity = folder_score
            average_score = np.mean([bleu_score, rouge_score, meteor_score, bert_similarity])
            average_scores.append(average_score)
            f.write(f"Folder: {folder_name}\n")
            f.write(f"BLEU: {bleu_score}\n")
            f.write(f"ROUGE-L: {rouge_score}\n")
            f.write(f"METEOR: {meteor_score}\n")
            f.write(f"BERT Similarity: {bert_similarity}\n")
            f.write(f"Average Score: {average_score}\n\n")

    # Calculate combined average score
    combined_average_score = np.mean(average_scores)
    print(f"Combined Average Score: {combined_average_score}")

# Run the main function
if __name__ == '__main__':
    main()
