# -*-coding:utf-8-*-
import os


def do_line(line):
    line = line.replace('\n','')
    fields = line.split('|')
    fields.pop(1)
    if len(fields) > 1:
        fields.pop(1)
    fields.append('10')
    fields.append('20')
    print('|'.join(fields))

file_obj = open("test2.txt")
all_lines = file_obj.readlines()
for line in all_lines:
    do_line(line)
file_obj.close()
