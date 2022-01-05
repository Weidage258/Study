### 第一步 创建仓库

GitHub 的个人主页 点击Repositories 再点击 NEW
        Repository name，仓库名称；
        Description，可选描述，也就是写不写都可以；
        Public，默认的仓库类型；
        Initialize this repository with a README，初始化仓库的信息文件，建议勾选

### 第二步 利用 SSH 完成 Git 与 GitHub 的绑定

####  生成 SSH key

​     输入ssh看看有无安装
​     再输入ssh-keygen -t rsa命令表示我们指定 RSA 算法生成密钥，然后敲三次回车键，
​        期间不需要输入密码，之后就就会生成两个文件，分别为id_rsa和id_rsa.pub，
​        即密钥id_rsa和公钥id_rsa.pub. 对于这两个文件，其都为隐藏文件，默认生成在以下目录：
​        Linux 系统：~/.ssh
​        Mac 系统：~/.ssh
​        Windows 系统：C:\Documents and Settings\username\\.ssh
​        Windows 10 ThinkPad：C:\Users\think\.ssh
​        添加页面的SSH key 进入我们的 GitHub 主页，先点击右上角所示的倒三角▽图标，然后再点击Settins
​        进行设置页面；点击我们的头像亦可直接进入设置页面
​        进入Settings页面后，再点击SSH and GPG Keys进入此子界面，然后点击New SSH key
​        我们只需要将公钥id_rsa.pub的内容粘贴到Key处的位置（Titles的内容不填写也没事），然后点击Add SSH key 即可。
​     在我们添加完SSH key之后，也没有明确的通知告诉我们绑定成功啊！不过我们可以通过在 Git Bash 中输入ssh -T 

### 第三步 提交代码

git init

####  git add --all 提交所有代码

​     git commit -m  "commit src file"       //git commit -m “(备注名字)”
​     git config --global user.email  提交邮箱
​     git config --global user.name "Your Name" 提交名字
​     提交到github上
​     git remote add origin git@github.com:Weidage258/project.git
​       建立分支 

​     git branch -m main
​     添加到github上
​     git push -u origin main        //强制提交 git push origin main -f

### 第四步 通过git下载github分支

##### 1.通过git下载github分支

```
$ git clone -b 分支名 网址.git 
$ git clone -b lesson-2 https://github.com/hemiahwu/vue-basic-playlist.git
```

git下载github所有分支代码到本地
任务一：下载地址为https://github.com/hemiahwu/vue-basic-playlist.git的所有分支代码到本地

具体步骤：
1、新建一个文件夹
2、选中文件夹——右击Git Bash Here
3、输入指令：
$ git clone https://github.com/hemiahwu/vue-basic-playlist.git

##### 2.下载单个文件

创建一个空的本地仓库

````
$ git init
````



连接远程仓库GitHub

````
$ git remote add -f origin <url>
````



我的操作：

````
$ git remote add -f origin https://github.com/aliyun/alicloud-android-demo.git
````



然后控制台会显示一些updating...信息。注意，这里的url必须是.git结尾的。

开启sparse checkout 模式

````
$ git config core.sparsecheckout true
````





告诉Git哪些文件或者文件夹是你真正想Check Out的
(你可以将它们作为一个列表保存在 .git/info/sparse-checkout 文件中。)

例如：

````
.git/info/sparse-checkout//固定操作 放置这个文件里面
$ echo libs// 在分支里面 要拿取的路径
$ git pull origin master//拉去需要得到的分支 通过刚刚的那个文件 会通过刚刚的路径找这个分支里面的数据 把它拉取到本地

$ echo libs >> .git/info/sparse-checkout
$ echo apps/register.go >> .git/info/sparse-checkout
$ echo resource/css >> .git/info/sparse-checkout
````



- 最后一步，拉取想要的分支

  `$ git pull origin master`

### 使用GitLFS上传大文件

先通过以下指令开启 LFS 功能：

```undefined
git lfs install
```

然后用以下指令选择需要 Git LFS 管理的文件扩展类型：

```javascript
git lfs track "*.文件类型"
//类似这样git lfs track "*.zip" 有多个 就这样添加多个
```

也可以是指定文件：

```javascript
git lfs track "文件名.文件类型"
```



再用以下指令确保`.gitattributes`是被追踪的：

```csharp
git add .gitattributes
```

也可以用以下指令显示当前跟踪的文件列表：（此步可跳过）

```undefined
git lfs ls-files
```

最后的步骤和普通上传一样，如下：

先执行添加指令，添加到缓存区，如下所示：

```csharp
git add . //必须加
```

之后直接就是提交，如下所示：

```sql
git commit -m "附加说明" //就算之前加过也要重新加 和之前的提交的一样
git push origin 分支名
```

至此，大功告成。

### fetch first出现问题的原因：

提示已经说明了，因为github上的远程库与本地库版本不一致，要先fetch first。

输入命令：git push origin master -f

以上命令，相当于 git push --force origin master

注意，origin master等可以根据自己的情况自行修改，但 git push -f 是不变的。

git push -u origin master在提交时报错Branch 'master' set up to track remote branch 'master' from 'origin'.

### git push -u origin master在提交时报错Branch 'master' set up to track remote branch 'master' from 'origin'.

1、添加到本地仓库

git add .

2、添加提交描述

git commit -m '提交'

3、提交前先从远程仓库主分支中拉取请求

git pull origin master

4、把本地仓库代码提交

git push -u origin master

### Git错误non-fast-forward的解决方法

1）先把git的东西fetch到你本地然后merge后再push

$ git fetch origin master

$ git merge origin FETCH_HEAD 

先抓取远程仓库的更新到本地，然后与你的本地仓库合并，（如果有冲突就要解决冲突后再合并，冲突问题比较复杂，这里就不详细说了），这样就可以使远程仓库和你本地仓库一致了，然后就可以提交修改了。

 

（2）这2句命令等价于
$ git pull origin master

（3）git pull --rebase origin master

重定基，可以是历史更加统一，即使提交历史趋向于一条直线。

 3.2、丢弃之前的历史，强推——谨慎使用

强推，即利用强覆盖方式用你本地的代码替代git仓库内的内容

$ git push -f 或者 $ git push --force



### failed to push some refs to

最后找到解决办法如下：
1、先删除远程 Git 仓库

$ git remote rm origin

2、再添加远程 Git 仓库

$ git remote add origin git@github.com:FBing/java-code-generator

如果执行 git remote rm origin 报错的话，我们可以手动修改gitconfig文件的内容

$ vi .git/config



### Git报错解决：OpenSSL SSL_read: Connection was reset, errno 10054 错误解决



*首先，造成这个错误很有可能是网络不稳定，连接超时导致的，
如果再次尝试后依然报错，可以执行下面的命令。*

**打开Git命令页面，执行git命令脚本：修改设置，解除ssl验证**

```
git config --global http.sslVerify "false"
```

