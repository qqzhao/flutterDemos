
### 1. python six issue

```
pip install --user -U
```

### 2. Android sdk not founded

```
export ANDROID_HOME=/Users/yourname/Library/Android/sdk
```

### 3. rename 资源

```
[root@localhost script]# rename image photo image*
将当前目录下所有以image开头的文件，换成以photo开关
[root@localhost rename]# ls
image_1.jpg  image_2.jpg  image_3.jpg  image_4.jpg  image_5.jpg
[root@localhost rename]# rename image photo image*
[root@localhost rename]# ls
photo_1.jpg  photo_2.jpg  photo_3.jpg  photo_4.jpg  photo_5.jpg

//将扩展名小写的.jpg改为大写.JPG
[root@localhost rename]# rename .jpg .JPG *.jpg
[root@localhost rename]# ls
photo_1.JPG  photo_2.JPG  photo_3.JPG  photo_4.JPG  photo_5.JPG
```


[Bareword “a” not allowed while “strict subs” in use at (eval 1) line 1.](http://cssor.com/linux-rename-files.html)

在Mac上使用下面的命令：
```
rename 's/Bitmap/preview_icon/'  *
```