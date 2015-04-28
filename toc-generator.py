#!/bin/python
import os

# os.walk()
# os.path.isdir()

sub_dirs = [f for f in os.listdir(".") if f.startswith("ch") and os.path.isdir(f)]

root_link = 'https://github.com/HengfengLi/SICP-Solutions/blob/master/'

for ch in sub_dirs:
    norlmal_files = [f for f in os.listdir("./" + ch) if not f.endswith('~')]
    
    filenames = [f.split('.')[0] for f in norlmal_files]
    
    text_list = []
    
    print
    print ch
    print "--------"
    
    for name, file in zip(filenames, norlmal_files):
        text_list.append('[%s](%s%s/%s)' \
                        % (name.split('-')[0], root_link, ch, file))
    
    print " ".join(text_list)
