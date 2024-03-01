#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs, os
from lxml import etree as ET

#Load all XMLs
xmls = []
xmls_addresses = []
xmls_files = []
folders = ["Day 00", "Day 01", "Day 02", "Day 03", "Day 04", "Day 05", "Day 06", "Day 07", "Day 08", "Day 09", "Day 10", "Final Day", "Post Game", "Unsorted"]

for folder in folders:
	for file in os.listdir("./SNSC3-Translation-master/"+folder):
		if file.endswith(".txt") or file.endswith(".xml"):
			newxml = ""
			newxml += "<all>\n"
			ascii = False
			
			f = codecs.open(os.path.join("./SNSC3-Translation-master/"+folder+"/", file), "r", "utf-8")
			
			#Some files are in Shift-JIS instead of UTF8.
			try:
				f.read()
				f.close()
				f = codecs.open(os.path.join("./SNSC3-Translation-master/"+folder+"/", file), "r", "utf-8")
			except:
				f.close()
				f = codecs.open(os.path.join("./SNSC3-Translation-master/"+folder+"/", file), "r", "shiftjis")
			
			for line in f:
				#Clean lines, fix wrong tags, replace full-width characters, replace game code tags
				line = line.strip()
				line = line.replace("<a>","<ascii>")
				line = line.replace("</a>","</ascii>")
				line = line.replace("<td>","(...)")
				line = line.replace("<e>","")
				line = line.replace("<end_line>","")
				line = line.replace("</end_line>","")
				line = line.replace("</end_line.","")
				line = line.replace("<three_dots>","(...)")
				line = line.replace("<three_dots.","(...)")
				line = line.replace("<player_name>","(name)")
				line = line.replace("<player_nickname>","(nick)")
				line = line.replace("<hearth>","(heart)")
				line = line.replace("<partner>","(partner)")
				line = line.replace("<weapon_type>","(weapon_type)")
				line = line.replace("<quote>","\"")
				line = line.replace("<paw>","(paw)")
				line = line.replace("<music_note>","(music_note)")
				line = line.replace("<option_1>","(Option1)")
				line = line.replace("<option_2>","(Option2)")
				line = line.replace("<option_3>","(Option3)")
				line = line.replace("</screen>","</ascii>")
				line = line.replace("</asciic>","</ascii>")
				line = line.replace(u"\uff01","!")
				line = line.replace(u"\uff1f","?")
				line = line.replace(u"\u3000"," ")
				line = line.replace(u"〜",u"～")
				line = line.replace(u"\t","")
				
				#Remove unneeded lines that aren't standard XML
				if line.startswith("<info") or line.startswith("<portrait") or line.startswith("<player") or line.startswith("<partner") or line.startswith("#"):
					line = "(emtpy)"
				
				#Add missing </ascii> tags
				if line == "<ascii>":
					ascii = True
				elif line == "</ascii>":
					ascii = False
				elif ascii and line.startswith("<"):
					newxml += "</ascii>\n"
					ascii = False
					
				#Remove repeated tags
				if line.startswith("<"):
					if newxml.endswith(line+"\n"):
						line = ""
				
				newxml += line
				newxml += "\n"

			f.close()
			newxml += "</all>"
			xmls.append(newxml)
			xmls_files.append(os.path.join("./SNSC3-Translation-master/"+folder+"/", file))
			#Get the XML address
			address = file.split("_")[-1]
			address = address[:-4]
			xmls_addresses.append(address)

#Convert the data from the XMLs into subtitle files
bad = codecs.open("badxml.txt", "w", "utf-8") #Store names of files with bad xml formatting here

for i in range(0, len(xmls)):
	xml = xmls[i]
	address = xmls_addresses[i]
	if not os.path.exists("./subtitles"):
		os.makedirs("subtitles")
	f = codecs.open("./subtitles/"+address+".txt", "w", "utf-8")
	
	xml_ok = True
	try:
		root = ET.fromstring(xml)
	except:
		xml_ok = False
		print "Bad XML: ",xmls_files[i]
		bad.write(xmls_files[i]+"\r\n")
		
	if xml_ok:
		for sjis in root.iter("sjis"):
			#Get the japanese lines and the translations
			parent = sjis.xpath('..')[0]
			jap = sjis.text
			eng = "Not translated"
			if len(parent.xpath('./ascii')) > 0:
				eng = parent.xpath('./ascii')[0].text
			elif len(parent.xpath('../ascii')) > 0:
				eng = parent.xpath('../ascii')[0].text
			if len(parent.xpath('./ascii')) > 1 or len(parent.xpath('../ascii')) > 1:
				print "ERROR: 2 ASCIIs FOR ONE JAP LINE"
			
			#Divide the texts into lines
			jap_parts = jap.strip().split("\n")
			eng_parts = eng.strip().split("\n")
			
			#Assign english line(s) to japanese line(s)
			
			#If there's no translation don't write anything (sometimes there's a repeated file with no translations)
			if eng == "Not translated":
				pass
			#Same ammount of japanese and english lines (one to one matching)
			elif len(jap_parts) == len(eng_parts):
				for i in range(0, len(jap_parts)):
					f.write(address+"\t")
					f.write(jap_parts[i]+"\t")
					f.write(eng_parts[i].strip()+"\n")
			#More english lines than japanese lines (last japanese line gets more than one english line)
			elif len(jap_parts) < len(eng_parts):
				for i in range(0, len(jap_parts)):
					f.write(address+"\t")
					f.write(jap_parts[i]+"\t")
					if i < len(jap_parts) - 1:
						f.write(eng_parts[i].strip()+"\n")
					else:
						for j in range(i, len(eng_parts)):
							f.write(eng_parts[j].strip())
							if j != len(eng_parts) - 1:
								f.write("(BR)")
						f.write("\n")
			#More japanese lines than english lines (Add extra english lines with "...")
			elif len(jap_parts) > len(eng_parts):
				for i in range(0, len(jap_parts)):
					f.write(address+"\t")
					f.write(jap_parts[i]+"\t")
					if i < len(eng_parts):
						f.write(eng_parts[i].strip()+"\n")
					else:
						f.write("...\n")
	f.close()
bad.close()
