```
# test file
[jialesun:~/jiale/]$ cat test.txt                                                                                                                                                                                          (devlop✱) 
1
2
3
4
5
6
```
### change column num to one row
### 修改列变成一行

```
[jialesun:~/jiale/]$ cat test.txt|tr '\n' '|'                                                                                                                                                                              (devlop✱) 
1|2|3|4|5|6|
```
# anthoer method (另外一个方法)
```
[jialesun:~/jiale/]$ cat test.txt|xargs|sed 's/ /|/g'                                                                                                                                                                      (devlop✱) 
1|2|3|4|5|6
```
