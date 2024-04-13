import os

def clean_directory(path=os.getcwd()):
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith('.o') or "." not in file:
                os.remove(os.path.join(root, file))

clean_directory()
