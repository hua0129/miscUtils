#!/usr/local/bin/python
# -*- coding:utf-8 -*-

import sys
import os
import os.path
import time

if __name__ == '__main__':
    dirpath = os.getcwd() 
    files = os.listdir(dirpath)
    for f in files:
        print (os.path.join(dirpath, f))
