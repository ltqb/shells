##### 1.how to sum a cloumn numbers
```shell
cat more_than_90days_files.txt |xargs -I {} du "{}"|awk 'BEGIN{sum=0}{sum=sum+$1;print $0}END{print sum}' >> 1019_90_shpx.txt 2>&1 &
```
