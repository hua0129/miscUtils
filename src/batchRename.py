#!/usr/local/bin/python
# -*- coding:utf-8 -*-

import sys
import os
import os.path
import time
import re

if __name__ == '__main__':

    if len(sys.argv) < 2 or sys.argv[1] not in [str(i) for i in range(1,9)]:
        print ("parameter is wrong:", sys.argv)
        exit(1)

    formatStr = "{:0=" + sys.argv[1] + "d}"
    dirpath = os.getcwd()

    files = os.listdir(dirpath)
    for f in files:
        num = re.sub('[^0-9]*','',f)
        if not num :
            continue
        nn = formatStr.format(int(num))
        nf = f.replace(num, nn)
        oldpath = os.path.join(dirpath,f)
        newpath = os.path.join(dirpath, nf)
        print ("rename: ", oldpath, newpath)
        os.rename(oldpath, newpath)
    print ("---end---") 
