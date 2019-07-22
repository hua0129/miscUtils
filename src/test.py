import os
import sys


dirpath = sys.argv[1]
filepath = sys.argv[2]

srcDir=arg1
def check_dir(dirpath): 
    if os.path.exists(dirpath):
        ap = os.path.abspath(dirpath)
        if os.path.isdir(ap):
            return ap

def check_file(filepath):
    if os.path.exists(filepath)
        ap = os.path.abspath(filepath)
        if os.path.isfile(ap):
            return ap

dirpath = check_dir(dirpath)
filepath = check_file(filepath)

if dirpath is None:
    print ("dir not found: ", sys.argv[1])

if filepath is None:
    print ("file not found: ", sys.argv[2])


