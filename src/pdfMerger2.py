#!/usr/local/bin/python
# -*- coding:utf-8 -*-

import PyPDF2 as pp
import os
import sys
import time

cwd = os.getcwd()
files = os.listdir(cwd)
writer = pp.PdfFileWriter()
for pdf in files:
    if not pdf.lower().endswith(".pdf"):
        continue

    reader = pp.PdfFileReader(pdf)
    for i in range(reader.numPages):
        page = reader.getPage(i)
        page.compressContentStreams()
        writer.addPage(page)
outfile = open( "merged_compress_" + str(int(time.time())) + ".pdf", 'wb')
writer.write(outfile)
outfile.close()

