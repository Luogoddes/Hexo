---
title: CentOS7将yum源更换为国内源保姆级教程
date: 2024-07-12 09:30:04
tags: CentOS7 yum换源
---

	在 CentOS 7 中更换 YUM (Yellowdog Updater Modified) 源到国内镜像可以显著提升软件包的下载速度。以下是一种常见的方法来更换为国内源，例如阿里云镜像：

1. **备份原有源配置文件**：
   ```sh
   sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
   ```
2. **下载国内源配置文件**：
   ```sh
   sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
   ```
   
   或者使用网易（163）的源：
   ```sh
   sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
   ```
3. **清理 yum 缓存并生成新缓存**：
   ```sh
   sudo yum clean all
   sudo yum makecache fast
   ```
4. **验证更改**：
检查 YUM 源是否已经更换成功，可以通过列出可用的软件包仓库：
   ```sh
   sudo yum repolist
   ```

	以上步骤会将 CentOS 7 的 YUM 源更换为国内镜像站点。如果你在执行过程中遇到权限问题，确保使用 `sudo` 前缀或者作为 root 用户登录。

	请注意，不同的国内镜像站可能会有不同的 URL，上述示例使用的是阿里云和网易（163）的镜像。你可以选择其他可靠的国内镜像站，只需将上述命令中的 URL 替换为对应镜像站的 URL 即可。

#### 一键执行脚本

```sh
#!/bin/bash
 
# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # 无颜色
 
# 定义YUM源选项
echo -e "${BLUE}请选择要更换的YUM源（默认使用阿里源）：${NC}"
echo -e "${BLUE}1) 阿里YUM源: http://mirrors.aliyun.com/repo/${NC}"
echo -e "${BLUE}2) 163(网易)YUM源: http://mirrors.163.com/.help/${NC}"
echo -e "${BLUE}3) 中科大Linux安装镜像源: http://centos.ustc.edu.cn/${NC}"
echo -e "${BLUE}4) 搜狐的Linux安装镜像源: http://mirrors.sohu.com/${NC}"
echo -e "${BLUE}5) 北京首都在线科技: http://mirrors.yun-idc.com/${NC}"
read -p "请输入选项 [1-5] (默认1): " choice
 
# 根据选择设置URL
case $choice in
    2)
        repo_url="http://mirrors.163.com/.help/CentOS7-Base-163.repo"
        ;;
    3)
        repo_url="http://centos.ustc.edu.cn/CentOS-Base.repo"
        ;;
    4)
        repo_url="http://mirrors.sohu.com/help/CentOS-Base-sohu.repo"
        ;;
    5)
        repo_url="http://mirrors.yun-idc.com/CentOS-Base.repo"
        ;;
    *)
        repo_url="http://mirrors.aliyun.com/repo/Centos-7.repo"
        ;;
esac
 
# 备份当前的YUM源配置文件
if [ -f /etc/yum.repos.d/CentOS-Base.repo ]; then
    sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    echo -e "${GREEN}已备份当前的YUM源配置文件到 /etc/yum.repos.d/CentOS-Base.repo.bak${NC}"
else
    echo -e "${RED}未找到 /etc/yum.repos.d/CentOS-Base.repo 文件，跳过备份步骤${NC}"
fi
 
# 下载选定的YUM源配置文件
sudo wget -O /etc/yum.repos.d/CentOS-Base.repo $repo_url
if [ $? -eq 0 ]; then
    echo -e "${GREEN}成功下载选定的YUM源配置文件${NC}"
else
    echo -e "${RED}下载选定的YUM源配置文件失败，请检查网络连接${NC}"
    exit 1
fi
 
# 清除YUM缓存并生成新的缓存
sudo yum clean all
sudo yum makecache
 
# 验证新的YUM源配置是否成功
sudo yum repolist -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}新的YUM源配置成功${NC}"
else
    echo -e "${RED}新的YUM源配置失败，请检查YUM源配置文件${NC}"
    exit 1
fi
 
# 下载并配置EPEL源
sudo wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
if [ $? -eq 0 ]; then
    echo -e "${GREEN}成功下载并配置EPEL源${NC}"
else
    echo -e "${RED}下载EPEL源失败，请检查网络连接${NC}"
    exit 1
fi
 
echo -e "${GREEN}YUM源更换并配置EPEL源成功${NC}"
 
# 提示用户是否需要进行系统更新
read -p "是否需要进行系统更新（默认不更新）？[y/N]: " update_choice
if [[ "$update_choice" =~ ^[Yy]$ ]]; then
    sudo yum upgrade -y
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}依赖包更新成功${NC}"
    else
        echo -e "${RED}依赖包更新失败${NC}"
    fi
else
    echo -e "${GREEN}跳过系统更新${NC}"
fi
```