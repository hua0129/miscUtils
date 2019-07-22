#!/usr/local/bin/python
# -*- coding:utf-8 -*-
#

import sys
import os
import time
from PyPDF2 import PdfFileMerger, PdfFileReader

def merge_all(path):
    """
    merge all pdfs in the directory
    """
    pdf_path_list = []
    pdf_merge = PdfFileMerger(False)
    file_list = os.listdir(path)
    for file in file_list:
        if not file.lower().endswith(".pdf"):
            continue
        file_path = os.path.join(path, file)
        pdf_merge.append(file_path)
    out_file = path + '_merge-' + str(int(time.time())) + '.pdf'
    pdf_merge.write(open(out_file, "wb"))

    print('save the merged pdf to ' + str(out_file))

if __name__ == '__main__':
    if len(sys.argv) < 2:
        dirpath = "."
    else:
        dirpath = sys.argv[1]
    
    def check_dir(dirpath): 
        if os.path.exists(dirpath):
            ap = os.path.abspath(dirpath)
            if os.path.isdir(ap):
                return ap
   
    dirpath = check_dir(dirpath)
    
    if dirpath is None:
        print ("dir not found: ", sys.argv[1])
    
    time1 = time.time()
    print ("dirpath:", dirpath)
    merge_all(dirpath)

    time2 = time.time()
    print (u"Spent time: " + str(time2 - time1) + 's')
