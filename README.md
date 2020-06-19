# batch-converter
Convert multiple files to new encoding, TIS-620 to UTF-8, ASCII to UTF-8

# prerequisite
- iconv availabe for OSX, linux

# How to use 

## Prepare list of files

example for `.aspx.list` file. ! you can change filename to anothor.

```txt
./folder-a/folder-b/file1.txt
./folder-a/file2.txt
./folder-a/file3.txt
```
or use command for file list of your files by `find` command.

```zsh
find . -type f -exec file --mime {} \;|grep aspx|grep -v charset=utf-8 > .aspx.list
```

- `-type f`, find only file. --- ค้นหาเฉพาะที่เป็นไฟล์เท่านั้น
- `-exec file --mime {} \;`, display perference of file that be found --- แสดงคุณลักษณะของไฟล์นั้นๆ
- `grep aspx`, keep the line include `aspx` --- แสดงบรรทัดที่มีข้อความว่า `aspx`
- `grep -v charset=utf-8`, discard the line including `charset=utf-8` --- ตัดบรรทัดที่มีข้อความว่า  `charset=utf-8` ออก



## Get started

1. setting parameter in file  `encoding-converter.sh`

```zsh
...
######################
# Setting Parameters #
######################

FROM_ENC=TIS-620         # Convert from ${FROM_ENC} encoding --- ระบุ encoding ของไฟล์เดิม
TO_ENC=UTF-8             # Convert to ${TO_ENC} encoding.    --- ระบุ encoding ใหม่ให้ไฟล์
INPUT_FILE=./.aspx.list  # list of files will be converted. ! it should be full path --- ควรใช้เป็น full-path เท่านั้น, ชื่อไฟล์เปลี่ยนตามที่เราเตรียมไว้

...
```
2. run file `encoding-converter.sh`, which is the same path of list of files.

```sh
./encoding-converter.sh
```
3. Additional, the original file will stored inside `.BACKUP-YYY-mm-dd` directory
