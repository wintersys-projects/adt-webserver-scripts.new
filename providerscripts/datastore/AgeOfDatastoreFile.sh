

time_file_written="`/usr/bin/s3cmd info s3://$1| grep "Last mod" | /usr/bin/awk -F',' '{print $2}'`"
time_now="`/usr/bin/date +%s`"
age_of_file_in_seconds="`/usr/bin/expr ${time_now} - ${time_file_written}`"
