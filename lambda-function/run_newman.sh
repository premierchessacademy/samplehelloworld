stages=`cat terraformapply.out | jq '.stage_names.value[]'`
url=`cat terraformapply.out | jq '.base_urls1.value'`
echo $url
for stage in $stages
do
 var2=`sed -e 's/^"//' -e 's/"$//' <<<"$stage"`
 url1=`sed -e 's/^"//' -e 's/"$//' <<<"$url"`

 echo '{"values": [{"key": "api_url","value":"'$url1$var2'"}]}' > $var2.txt
 newman run empty.json -e $var2.txt
 echo $stage

done