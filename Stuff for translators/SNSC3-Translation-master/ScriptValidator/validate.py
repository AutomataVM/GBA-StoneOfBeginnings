import argparse
import glob
import os

from parseXml import validateFile
from ElementTree import ParseError

parser = argparse.ArgumentParser(description='Validate SNSC3 script files.')
parser.add_argument('folders', type=str, nargs='+', help='Folder(s) containing XML files to validate.')
args = parser.parse_args()

num_files = 0
for folder in args.folders:
  for file in glob.glob('../{}/*.xml'.format(folder)):
    validateFile(file)