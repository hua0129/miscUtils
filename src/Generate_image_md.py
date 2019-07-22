#!/usr/local/bin/python
# -*- coding:utf-8 -*-
# Generate md file from an images dir ignoring subdir
# parameter is relative dir or absolue dir

import sys
import os

print(sys.argv[0])
print(sys.argv[1])

current_dir=os.path.dirname(sys.argv[0])
imageDir=os.path.join(current_dir,sys.argv[1])

mdcontent=""

list = os.listdir(imageDir) #列出文件夹下所有的目录与文件
for i in range(0,len(list)):
    path = os.path.join(imageDir,list[i])
    if os.path.isfile(path):
        mdcontent += "\n### " + list[i] + "\n"
        mdcontent += "![" + list[i] +"](" + sys.argv[1]+"/" + list[i] + ")\n"

fp=open(os.path.join(current_dir, sys.argv[1] + "_images.md"), "a+", encoding="utf-8")
fp.write(mdcontent)
fp.close()
print (mdcontent)
