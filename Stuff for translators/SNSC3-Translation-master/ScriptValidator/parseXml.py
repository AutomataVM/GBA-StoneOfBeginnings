import warnings
import constants
from ElementTree import ElementTree
from rules import verify

def replacePseudoXml(bytes):
  """
  Replaces all SNSC3 specific pseudo-XML with valid xml for parser to process.

  :param bytes: bytearray read directly from file
  :return: bytearray with pseudo-XML elements removed/replaced
  """
  if any(el in bytes for el in constants.LINE_ELS):
    return constants.NEWLINE

  bytes = bytes.replace(constants.END_LINE_OPEN, constants.END_LINE_CLOSED)
  bytes = bytes.replace(constants.THREE_DOTS_OPEN, constants.THREE_DOTS_CLOSED)
  bytes = bytes.replace(constants.PLAYER_NAME_OPEN, constants.PLAYER_NAME_CLOSED)
  bytes = bytes.replace(constants.PLAYER_NICKNAME_OPEN, constants.PLAYER_NICKNAME_CLOSED)
  bytes = bytes.replace(constants.HEARTH_OPEN, constants.HEARTH_CLOSED)
  bytes = bytes.replace(constants.PAW_OPEN, constants.PAW_CLOSED)
  bytes = bytes.replace(constants.PARTNER_OPEN, constants.PARTNER_CLOSED)
  bytes = bytes.replace(constants.WEAPON_TYPE_OPEN, constants.WEAPON_TYPE_CLOSED)
  bytes = bytes.replace(constants.BREAK_OPEN, constants.BREAK_CLOSED)
  bytes = bytes.replace(constants.QUOTE_OPEN, constants.QUOTE_CLOSED)
  bytes = bytes.replace(constants.MUSIC_NOTE_OPEN, constants.MUSIC_NOTE_CLOSED)
  bytes = bytes.replace(constants.OPTION_1_OPEN, constants.OPTION_1_CLOSED)
  bytes = bytes.replace(constants.OPTION_2_OPEN, constants.OPTION_2_CLOSED)


  return bytes


def readXml(file):
  """
  Reads from a file and processes it to remove SNSC3 specific pseudo-XML.
  TODO: ignore content between <sjis> elements.
  The reason is that ElementTree.parse REALLY doesn't like them.

  :param file: file to read from
  :return: bytearray representation of the file
  """
  bytes = bytearray()
  bytes += constants.ROOT_OPEN
  for line in file.readlines():
    line = replacePseudoXml(line)
    bytes += line
  bytes += constants.ROOT_CLOSE
  return bytes

def validateFile(filename):
  """
  Checks if a given file follows SNSC3 pseudo-XML.
  Errors from small files, such as those containing only
  <location> blocks, are suppressed as these cause
  major issues for the parser.
  
  :param filename: name of the file to read from
  :raises ParseError: bubbled up from ElementTree
  """
  with open(filename, 'rb') as xml_file:
    bytes = readXml(xml_file)
    try:
      print('Validating ' + filename + '...')
      tree = ElementTree().parseBytes(bytes)
      if not verify(tree):
        warnings.warn(filename + ' is invalid!')
    finally:
      xml_file.close()
