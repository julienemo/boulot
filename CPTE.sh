#!/bin/bash

PDF=$1

pdftohtml -nodrm -hidden -i -s -xml $PDF
XML=`ls -tr *.xml | tail -n1`
echo $XML
grep ' width="763" height="9" font="5">' $XML | sed -e 's/<[^>]*>//g'  > $XML.txt
cat $XML.txt | 
  sed -r 's/^(.{5})/\1;:/' | # Date
  sed -r 's/([^:]*):.(.{2}).0*([0-9]+).(.{3})/\1\2\3\4;:/' | #Numero
  sed -r 's/([^:]*):.{13}(.{22})/\1\2;:/' | # Nom Prenom
  sed -r 's/([^:]*):.(.{6}).(.).{14}/\1\2;\3;:/' | # Poids v
  sed -r 's/([^:]*):(.{6}).(.).*/\1\2;\3;/' > $XML.csv # Tax A
  
