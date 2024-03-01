import glob
import unittest
import warnings

from ElementTree import ParseError
from parseXml import validateFile


class TestScriptValidate(unittest.TestCase):
  # File formatting rules
  def testValidateBasicFile(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/base.xml')
      validateFile(file[0])
      assert len(w) == 0

  def testValidateFileWithSymbols(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/symbols.xml')
      validateFile(file[0])
      assert len(w) == 0

  def testMisspelledLineTagRaisesError(self):
    with self.assertRaises(ParseError) as cm:
      file = glob.glob('./test/misspelledLineTag.xml')
      validateFile(file[0])

  def testMisspelledSymbolRaisesError(self):
    with self.assertRaises(ParseError) as cm:
      file = glob.glob('./test/misspelledSymbol.xml')
      validateFile(file[0])

  # <end_line> element rules
  def testAsciiWithoutEndlineLogsWarning(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/asciiWithoutEndline.xml')
      validateFile(file[0])
      assert len(w) == 1

  def testAsciiCharactersAfterEndLineLogsWarning(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/asciiEndLineTrailingCharacters.xml')
      validateFile(file[0])
      assert len(w) == 1

  def testTooManyEndLinesLogsWarning(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/asciiExcessiveEndLines.xml')
      validateFile(file[0])
      assert len(w) == 1

  # Line content rules
  def testAsciiLineTooLongRaisesError(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/asciiLineLength1.xml')
      validateFile(file[0])
      assert len(w) == 1

  def testAsciiLineWithLeadingWhitespaceIsValid(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/asciiLineLength2.xml')
      validateFile(file[0])
    assert len(w) == 0

  def testAsciiLineWithSymbolsIsTooLong(self):
    with warnings.catch_warnings(record=True) as w:
      file = glob.glob('./test/asciiLineLength3.xml')
      validateFile(file[0])
      assert len(w) == 1

if __name__ == '__main__':
  unittest.main()
