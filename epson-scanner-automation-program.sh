# TYPE: Korn Shell script.
# PURPOSE: Scan gray scale documents on Epson scanner to PDF file. Can unite multiple PDF files in work directory, automatically send united PDF to your Email account, and then automatically archive them.
# REQUIRES: ksh, scanimage, tesseract, msmtp, heirloom-mailx, imagemagick, pdfunite
# REVISED: 20130301
# AUTHOR: Mark Rijckenberg
#!/bin/ksh

while [[ $ACTION -ne 3 ]]; do
  WORKDIR=/tmp
  name=Rijckenberg.Mark
  tiffname=scannedfile.tiff
  pdfname=scannedfile.pdf
  datepdf=$(date +"%Y_%m_%d_%H_%M_%S")
  dateunitedpdf=$(date +"%Y_%m_%d")
  pdfquantity=$(ls|grep pdf|wc -l)
  cd $WORKDIR
  echo "Press 1 to scan single document and save it in your work directory as a PDF"
  echo "Press 2 to unite multiple PDF files in your work directory, send united PDF to your Email account, and then archive them"
  echo "Press 3 to exit shell program"  
  read ACTION

  
      if [[ $ACTION -eq 1 ]]; then   
      
SOURCE=""
 
if [ $# -gt 1 ]
then
 
SOURCE="--source ADF -l 3"
outname=temp
pbreak=$1
 
echo "$pbreak" | egrep "[^0-9,]+"
if [ $? -ne 1 ]
then
echo "Check Sequence List !"
exit 1
fi
else
 
pbreak=99
outname=$1
SOURCE="--batch-count=1"
 
fi
 
startdir=$(pwd)
tmpdir=scan-$RANDOM
 
cd /tmp
mkdir $tmpdir
cd $tmpdir
echo "################## Scanning ###################"
scanimage -x 210 -y 297 --batch=out%02d.tif --format=tiff --mode Gray --resolution 300 $SOURCE
 
start=1
cnt=1
sc=$(echo "$pbreak" | cut -d"," -f1-99 --output-delimiter=" " | wc -w)
for pb in $(echo "$pbreak" | cut -d "," -f1-99 --output-delimiter=" ")
do
ende=$(expr $start + $pb - 1)
pnr=0
i=1
echo "############ Page-Sequence ($cnt), Pages: $pb, Start: $start, End: $ende ############"
tpages=""
for page in $(ls out*.tif); do
pnr=$(expr $pnr + 1)
if [ $pnr -ge $start -a $pnr -le $ende ]
then
echo "... Converting"
# increase contrast and reduce colordepth
convert $page -level 15%,85% -depth 2 "b$page"
echo "... OCRing"
tpages="$tpages b$page"
i=$(expr $i + 1)
echo -n " "
tesseract $page $page -l fra
if [ $sc -gt 1 ]
then
cnts=`printf %02d $cnt`
cat $page.txt >> $outname.$cnts.txt
else
cat $page.txt >> $outname.txt
fi
 
fi
done
 
echo "... Converting to PDF"
#Use tiffcp to combine output tiffs to a single multipage tiff
tiffcp $tpages output.tif
#Convert the tiff to PDF
if [ $sc -gt 1 ]
then
cnts=`printf %02d $cnt`
tiff2pdf -z output.tif > $startdir/$outname.$cnts.pdf
mv $outname.$cnts.txt $startdir
else
tiff2pdf -z output.tif > $startdir/$outname.pdf
mv $outname.txt $startdir
fi
 
start=$(expr $start + $pb)
cnt=$(expr $cnt + 1)
 
done
 
cd ..
echo "################ Cleaning Up ################"
rm -rf $tmpdir
cd $startdir
mv  \.pdf `echo $datepdf``echo $pdfname`
rm \.txt
      

	    elif [[ $ACTION -eq 2 ]]; then
		    if  [[ $pdfquantity -gt 1 ]];then
		    pdfunite *.pdf  `echo $dateunitedpdf``echo $pdfname`	           
		    # First create and configure the files ~/.msmtprc  and ~/.mailrc
		    # The file ~/.msmtprc should contain the line   set sendmail=/usr/bin/msmtp
		    # Replace emailaddress@somewhere.com with the correct destination Email address
		    echo "Hi, here are my scanned files from `echo $dateunitedpdf`" | mail -s `echo $dateunitedpdf``echo $pdfname` -a `echo $name``echo $dateunitedpdf``echo $pdfname` emailaddress@somewhere.com
		    mkdir `echo $dateunitedpdf`
		    mv *.pdf `echo $dateunitedpdf`
	           fi
		    if  [[ $pdfquantity -eq 1 ]];then
	           
		    # First create and configure the files ~/.msmtprc  and ~/.mailrc
		    # The file ~/.msmtprc should contain the line   set sendmail=/usr/bin/msmtp
		    # Replace emailaddress@somewhere.com with the correct destination Email address
		    mv *.pdf  `echo $dateunitedpdf``echo $pdfname`
		    echo "Hi, here are my scanned files from `echo $dateunitedpdf`" | mail -s `echo $dateunitedpdf``echo $pdfname` -a `echo $name``echo $dateunitedpdf``echo $pdfname` emailaddress@somewhere.com
		    mkdir `echo $dateunitedpdf`
		    mv *.pdf `echo $dateunitedpdf`
	           fi


      fi

done
