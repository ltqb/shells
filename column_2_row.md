### test file 测试文件
```
[jialesun:~/jiale/]$ cat test.txt                     
1
2
3
4
5
6
```
### change column num to one row 修改列变成一行

```
[jialesun:~/jiale/]$ cat test.txt|tr '\n' '|'  
1|2|3|4|5|6|
```
### another method 另外一个方法
```
[jialesun:~/jiale/]$ cat test.txt|xargs|sed 's/ /|/g'  
1|2|3|4|5|6
```
