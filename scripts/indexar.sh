cd /mnt/cpdoc/json
#!/bin/bash
for i in $( ls /mnt/cpdoc/json ); do
        echo $i
        CT="Content-Type:application/json"
        echo sudo curl "http://localhost:8983/solr/blacklight-core/update/json?literal.id=doc${i%.json}&commit=true --data-binary @$i -H $CT" 
	#sudo curl "http://localhost:8983/solr/blacklight-core/update/extract?literal.id=doc${i%.json}&commit=true" -F "myfile=@/var/www/cpdoc/dhbb/${i%.json}.html"
	#cat /mnt/cpdoc/meta_dario/${i%.markdown}.markdown /mnt/cpdoc/verbete/text/${i%.markdown}.text /mnt/cpdoc/verbete/ref/${i%.markdown}.ref >> /mnt/cpdoc/full/2014-02-16-${i%.markdown}.markdown	
done

#curl "http://localhost:8983/solr/update?commit=true"
