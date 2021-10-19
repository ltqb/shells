##### 1.find more than 90 days files in path
```
find ${PATH} -type f -atime +90 >> m_t_90_day_files.txt 2>&1 &
```

##### 2.how to sum a cloumn numbers
```shell
cat more_than_90days_files.txt |xargs -I {} du "{}"|awk 'BEGIN{sum=0}{sum=sum+$1;print $0}END{print sum}' >> 1019_90_shpx.txt 2>&1 &
```
