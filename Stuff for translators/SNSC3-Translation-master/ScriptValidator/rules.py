import logging
import constants


def elementContentToString(ascii, end_els):
  """
  Converts the content of an ascii element into a single string.
  """
  lines = ''
  lines += (ascii.text.strip())
  for el in end_els:
    if el.tail is not None and len(el.tail) > 0:
      lines += (el.tail)
  return lines


def verifyEndlines(ascii, warn_list):
  """
  Checks <end_line> elements exist, match the number of lines, 
  and are placed at the end of each line.
  
  :param ascii: root element
  :param warn_list: string list of warning
  :return: 
  """
  end_els = ascii.findall('end_line')
  inner_text = ''.join(ascii.itertext())
  if len(end_els) != inner_text.count('\n') - 1:
    warn_list.append('Number of <end_line> elements is incorrect!')
  for el in end_els:
    if el.tail is None or el.tail[0] != '\n':
      warn_list.append('<end_line> element not placed at end of line!')


def determineSymbolLength(ascii):
  """
  Determines the character length of symbol elements such as <three_dots>
  within each line, delimited by <end_line>.
  
  :param ascii: root element
  :return: character length for each line
  """
  len_array = []
  len = 0
  for el in ascii:
    if el.tag in constants.SYMBOLS:
      len += constants.SYMBOL_LEN
    elif el.tag in constants.NAME_ELS:
      len += constants.NAME_EL_LEN
    else:
      len_array.append(len)
      len = 0
  return len_array


def verifyLineLength(ascii, warn_list):
  """
  Validates if length of lines within <ascii> elements conforms to specification.
  Warnings are added to warn_list for each inconsistency.
  
  :param ascii: root element
  :param warn_list: string array of warnings
  :return: 
  """
  end_els = ascii.findall('end_line')
  lines = elementContentToString(ascii, end_els).split('\n')
  line_symbols = determineSymbolLength(ascii)

  index = 0
  for line, symbol_len in zip(lines, line_symbols):
    if len(line.strip()) + symbol_len > constants.MAX_LINE_LENGTH:
      warn_list.append('Line is longer than ' + str(constants.MAX_LINE_LENGTH) + ' characters!')


def verify(tree):
  """
  Performs validation of content between <ascii> elements, then logs any warnings.
  
  :returns: True iff no elements have warnings
  """
  valid = True
  for ascii in tree.iter('ascii'):
    warn_list = []
    verifyEndlines(ascii, warn_list)
    verifyLineLength(ascii, warn_list)
    if len(warn_list) > 0:
      valid = False
      print(''.join(ascii.itertext()))
      for str in warn_list:
        logging.warning(str)
  return valid