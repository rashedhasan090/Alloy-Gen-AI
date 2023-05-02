import os
import re
from nltk.tokenize import word_tokenize
from nltk.translate import meteor_score

def get_bug_line(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            if 'Bug' in line:
                if i + 1 < len(lines):
                    next_line = lines[i + 1].strip()
                    return next_line
                else:
                    return None
    return None

def tokenize_sentence(sentence):
    return word_tokenize(sentence.lower())

def find_matching_files(source_folder, destination_folders):
    matching_files = []
    source_files = [f for f in os.listdir(source_folder) if f.endswith('.als')]

    for source_file in source_files:
        source_file_path = os.path.join(source_folder, source_file)
        source_bug_line = get_bug_line(source_file_path)
        if source_bug_line is None:
            continue

        for dest_folder in destination_folders:
            dest_files = [f for f in os.listdir(dest_folder) if f.endswith('.als')]

            for dest_file in dest_files:
                dest_file_path = os.path.join(dest_folder, dest_file)
                dest_bug_line = get_bug_line(dest_file_path)

                if dest_bug_line is not None:
                    matching_files.append((source_file_path, dest_file_path, source_bug_line, dest_bug_line))

    return matching_files

def calculate_similarity_scores(matching_files):
    scores = []
    for source_file, dest_file, source_bug_line, dest_bug_line in matching_files:
        source_tokens = tokenize_sentence(source_bug_line)
        dest_tokens = tokenize_sentence(dest_bug_line)
        score = meteor_score.meteor_score([source_tokens], dest_tokens)
        scores.append(score)

    return scores

def calculate_average_score(scores):
    if scores:
        return sum(scores) / len(scores)
    else:
        return 0.0

def save_scores_to_file(folder_names, scores, average_score):
    with open('METEOR_scores.txt', 'w') as file:
        for i, folder_name in enumerate(folder_names):
            file.write(f'Folder {i+1}: {folder_name}\n')
            file.write(f'Score: {scores[i]}\n\n')

        file.write(f'Average Score: {average_score}')

source_folder = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/original files'
destination_folders = [
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_1',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_2',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_3',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_4',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_5',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_6',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_7',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_8',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_9',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/score_calculations_2/Test_Run_10']



# source_folder = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/original files'
# destination_folders = ['/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 1',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 2',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 3',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 4',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 5',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 6',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 7',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 8',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 9',
#                        '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 10']
#



matching_files = find_matching_files(source_folder, destination_folders)
scores = calculate_similarity_scores(matching_files)
average_score = calculate_average_score(scores)
save_scores_to_file(destination_folders, scores, average_score)

print(f'Average Similarity Score: {average_score}')
