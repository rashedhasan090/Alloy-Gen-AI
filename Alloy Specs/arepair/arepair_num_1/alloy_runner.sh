jython -c "from edu.mit.csail.sdg.alloy4whole import SimpleGUI; \
from edu.mit.csail.sdg.alloy4compiler.parser import CompUtil; \
from edu.mit.csail.sdg.alloy4compiler.translator import TranslateAlloyToKodkod; \
import sys, os; \
file_path = sys.argv[1]; \
if not os.path.isfile(file_path): \
    sys.exit('File not found.'); \
model = CompUtil.loadModelFromFile(None, file_path); \
options = TranslateAlloyToKodkod.getOptions(); \
options.solver = 'MiniSatProverJNI'; \
kkresult = TranslateAlloyToKodkod.execute_command(None, model.getAllCommands(), options); \
with open('output.txt', 'w') as f: \
    f.write(str(kkresult)); \
print(kkresult)" file_path.als
