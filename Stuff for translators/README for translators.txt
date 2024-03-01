*** xml 2 subtitles ***

This is a Python 2.7 script that generates the folder with subtitle files to use with The Subtitler.
It requires the lxml module, you can install it with "pip install lxml".

It gathers the xml files from the SNSC3-Translation-master folder and from that it generates the subtitle files
into a folder named "subtitles". After updating the translation and generating the subtitle files, the subtitles folder 
can be copied to replace the one in the folder with subtitler.exe.

Whenever the script finds an xml file with bad formatting, it won't be able to parse it and it will be listed
in the badxmls.txt file. The bad formatting can be tags that weren't closed, typos in tags, repeated tags, etc.


*** The Subtitler ***

The Subtitler includes some features to aid in translating.

By running the subtitler from "subtitler with console.bat" you'll get a console below the dialog frame.
Here you can see the script address that line is located at, the japanese line and the translation.
You can use the script address to find the xml file that line is located at.

Whenever The Subtitler finds an untranslated line, it will add it to the file "untranslated.txt" with its
correspondent script address. This way it's easy to find untranslated lines from NPCs, shops, etc.

Note: Using savestates will make several untranslated lines to appear, this can flood the "untranslated.txt" with
fake lines that are actually translated. Avoid using savestates while trying to look for lines to translate.