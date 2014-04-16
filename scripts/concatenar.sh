#!/bin/bash
for i in $( ls /mnt/cpdoc/meta_dario ); do
	cat /mnt/cpdoc/meta_dario/${i%.markdown}.markdown /mnt/cpdoc/verbete/text/${i%.markdown}.text /mnt/cpdoc/verbete/ref/${i%.markdown}.ref >> /mnt/cpdoc/full/2014-02-16-${i%.markdown}.markdown	
done
