# GIT 使用

## 目录
  
- [Git简介](#简介)
- [安装](#安装)
- [基本步骤](#基本步骤)
- [同步远程仓库](#同步远程仓库)
- [常见错误](#常见错误)

[相关内容](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)
-- --
## 简介
  - Git是什么？
   Git是目前世界上最先进的分布式版本控制系统（没有之一）。
  - 功能类似svn 可以在Windows、linux 多平台使用 早期主要为Linux设计

## 安装
  - Linux安装
    - Ubuntu: sudo apt-get install git
    - Other linux： 下载git 官网源码 执行 ./config make  make install
  - Windows: 从git官网下载安装包 [链接](https://git-scm.com/download/win)

## 基本步骤
   - 安装完成后 windows 运行Git Bash 
   - 设置用户
     - git config --global user.name "Your Name"
     - git config --global user.email "email@example.com"
   - **创建git仓库目录并初始化**
     - mkdir learngit
     - cd learngit
     - pwd
     - git init 管理当前目录 生成.git
   - **管理文件并上传**
     - git add readme.txt
     - git comit -m " wrote a readme file"
   - **git 仓库日志及回退**
     - git status 仓库状态日志
     - git diff 显示文件修改内容
     - git log 显示提交日志 git log --pretty 简洁方式查看
     - git reset --hard HEAD^
       - HEAD 表示当前版本 一个^表示上一个版本 之前100个版本写为HEAD~100
       - 回退到最新版本 找到最新版本的commit编码 git reset --hard 364545 （只要输前几位 会自动匹配）
     - git reflog 查看命令历史
## 同步远程仓库 
   - 这里使用github远程仓库
   - 先初始化本地仓库后 
   - git remote add orgin git@github.com:luyueixn93(github账号名)/py1.git(项目名)
     - 若添加失败 显示 fatal：remote origin already esist 先输入git remote rm origin
   - git pull -f --all 同步远端到本地
   - git add . git commit --am "init"
   - git push -u origin master
   - git push -u orign master -f 强制覆盖远端仓库
   
## 常见错误
  - 摘自网络[资料](https://blog.csdn.net/dengjianqiang2011/article/details/9260435)