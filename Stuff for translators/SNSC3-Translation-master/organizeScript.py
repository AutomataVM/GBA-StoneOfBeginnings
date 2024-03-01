#	This Python script will parse ArrangedScriptPointers and copy/rename files to make it easier to tell which files correspond to which day.
# Note that I've modified ArrangedScriptPointers slightly to correct errors and make it compatible with this script.
#
# To use, grab the scriptTXT and sn3_export_story, then unzip them so that the folder structure looks like:
# 
# ArrangedScriptPointers.txt
# organizeScript.py
# scriptTXT (folder)
#   <name>.txt
# sn3_export_story (folder)
#   <name>.txt

import glob;
import os;
import shutil;
import itertools;

def init():
  global PATH_SCRIPT_JP
  global PATH_SCRIPT_EN
  PATH_SCRIPT_JP = os.path.abspath(os.curdir) + "\\sn3_export_story\\"
  PATH_SCRIPT_EN = os.path.abspath(os.curdir) + "\\scriptTXT\\"
  return

def createDirectory(name):
  if not os.path.exists(name):
    os.makedirs(name)
  return;
  
def findAndCopy(filename, numFiles):
  sanitizedName = filename.lstrip('0').lower()
  for pathJP in glob.glob(PATH_SCRIPT_JP + "*" + sanitizedName + ".txt"):
    oldFilename = pathJP[pathJP.rfind("\\")+1:]
    newFilename = str(numFiles).zfill(3 ) + "_" + oldFilename[:len(oldFilename)-3] + "xml"
    
    copyAndRename(os.path.abspath(os.curdir), pathJP, oldFilename, newFilename)
  
def copyAndRename(destDir, path, oldFilename, newFilename):
  # Build paths
  srcFile = os.path.join(PATH_SCRIPT_JP, oldFilename)
  destFile = os.path.join(destDir, oldFilename)
  newDestFileName = os.path.join(destDir, newFilename)
  
  # Copy old file to Day X/
  if os.path.exists(destFile) or os.path.exists(newDestFileName):
    return
  shutil.copy(srcFile, destDir)
  
  # Rename file to #_name.txt
  newDestFileName = os.path.join(destDir, newFilename)
  os.rename(destFile, newDestFileName)
  return;
  
# Begin body  

init()
print(PATH_SCRIPT_JP)
numFiles = 0
with open('ArrangedScriptPointers.txt', 'r') as f:
  for line in f:
    line = line.rstrip(' \t\r\n\0') 
    if len(line) == 0:
      os.chdir("..")
      numFiles = 0
      continue
    else:
      if line[0] != '0':
        createDirectory(line)
        os.chdir(line)
        numFiles = 0
      else:
        findAndCopy(line, numFiles)
        numFiles += 1