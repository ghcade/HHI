#!/bin/bash
echo "-------------------------------"
echo "HTTP Header Host Injection Test"
echo "-------------------------------"
read -p "Target URL: " url
read -p "Fake Header Host: " fhh
#fstr="$url"
#http_del=${fstr/"http://"}
#https_del=${http_del/"https://"}
#lstr=${https_del/"/"}
TODAY=`date '+%Y%m%d%H%M'`
echo "-------------------------------"
echo "Target Response Output File $TODAY""_response.txt"
echo " "
#echo "-------------------------------"
curl -s -k --header "Host: $fhh" $url > "$TODAY"_response.txt
#echo -e "\n-------------------------------"
echo "Check HTTP Header Host Injection"
echo "-------------------------------"
curl -s -k --header "Host: $fhh" $url | grep "$fhh" > "$TODAY"_check.txt
if [ -s "$TODAY"_check.txt ]
then
  echo "Target Response Content Search $fhh: "
  echo " "
  cat "$TODAY"_check.txt
  echo " "
  echo -n "There may be "
  wc -l "$TODAY"_check.txt | awk '{printf $1}'
  rm "$TODAY"_check.txt
  echo " vulnerabilities!"
else
  echo "No vulnerability!"
fi
echo -e "-------------------------------"
echo " "
echo "done..."
