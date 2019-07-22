#!/usr/local/bin/python
# -*- coding:utf-8 -*-

import os
import sys
import time

cwd = os.getcwd()
files = os.listdir(cwd)
for pdf in files:
    if not pdf.lower().endswith(".pdf"):
        continue
    rs = "_decrypted"
    if rs in pdf:
        nname = pdf.replace(rs,"")
        print ("rename: ", pdf, nname)
        os.rename(pdf, nname)

