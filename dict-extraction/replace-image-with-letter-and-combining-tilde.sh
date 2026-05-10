#!/bin/bash

#
# To be used with "Grande Dicionário da Língua Portuguesa da Porto Editora".
#
# Replaces `<img>` tags with relevant letter and combining tilde.  
#
# 1. Convert the MOBI to HTMLZ using Calibre
# 2. Unzip the HTMLZ file into a folder.
# 3. Run this script to replace `<img>` tags.
# 4. Zip again the folder into HTMLZ.
# 5. Replace the old HTML with the new one.
#

sed -Ei 's|<img hspace="0" lorecindex="00003" src="images/000003.png" class="calibre_18" />|ɐ̃|g' index.html
sed -Ei 's|<img hspace="0" lorecindex="00006" src="images/000004.png" class="calibre_18" />|j̃|g' index.html
sed -Ei 's|<img hspace="0" lorecindex="00009" src="images/000005.png" class="calibre_18" />|w̃|g' index.html

