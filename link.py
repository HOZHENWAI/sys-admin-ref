#!/bin/python3

import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("old_path")
parser.add_argument("new_path")

def link_path(old_path, new_path):
    for name in os.listdir(old_path):
        opath = f"{old_path}/{name}"
        npath = f"{new_path}/{name}"
        if os.path.isdir(opath):
            try:
                os.mkdir(npath)
            except Exception as e:
                print(e)
            link_path(opath, npath)
        else:
            os.link(opath, npath)
            
if __name__=="__main__":
    args = parser.parse_args()
    try:
      os.mkdir(args.new_path)
    except:
      pass
    try:
      link_path(args.old_path, args.new_path)
    except Exception as e:
      print(e)
