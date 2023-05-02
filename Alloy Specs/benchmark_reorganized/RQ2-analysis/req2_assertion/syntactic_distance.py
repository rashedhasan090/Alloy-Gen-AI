import os
import nltk.translate.bleu_score as bleu
from nltk.translate.meteor_score import single_meteor_score
from rouge import Rouge
from bert_score import score as bert_score

def get_lines_with_bug(file_path):
    lines_with_bug = []
    with open(file_path, 'r') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            if 'Bug' in line:
                lines_with_bug.append(lines[i+1].strip())
    return lines_with_bug

def calculate_syntactic_distances(source_lines, destination_lines):
    total_distance = 0
    for source_line in source_lines:
        min_distance = float('inf')
        for dest_line in destination_lines:
            distance = bleu.sentence_bleu([source_line.split()], dest_line.split())
            if distance < min_distance:
                min_distance = distance
        total_distance += min_distance
    return total_distance / len(source_lines)

def calculate_metrics(source_folder, destination_folders):
    results = {}
    for destination_folder in destination_folders:
        distances = []
        source_files = os.listdir(source_folder)
        dest_files = os.listdir(destination_folder)

        for source_file in source_files:
            if source_file.endswith('.als'):
                source_file_path = os.path.join(source_folder, source_file)
                source_lines_with_bug = get_lines_with_bug(source_file_path)

                for dest_file in dest_files:
                    if dest_file.endswith('.als'):
                        dest_file_path = os.path.join(destination_folder, dest_file)
                        dest_lines_with_bug = get_lines_with_bug(dest_file_path)

                        distance = calculate_syntactic_distances(source_lines_with_bug, dest_lines_with_bug)
                        distances.append(distance)

        avg_distance = sum(distances) / len(distances)
        results[destination_folder] = avg_distance

    return results

def save_results_to_file(results):
    with open('results.txt', 'w') as file:
        for folder, distance in results.items():
            file.write(f'{folder}: {distance}\n')

source_folder = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/original files (assertion)'
destination_folders = ['/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_1',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_2',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_3',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_4',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_5',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_6',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_7',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_8',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_9',
'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/req2_assertion/assertion/Test_Run_10']

metrics_results = calculate_metrics(source_folder, destination_folders)
save_results_to_file(metrics_results)
