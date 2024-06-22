@echo off

:menu
echo ======================================================
echo -- 1. 查看Git状态      git status
echo -- 2. 配置用户名-邮箱  git config --global user.
echo -- 3. 查询配置         git config --global --list
echo -- 4. 本地化创建       git init
echo -- 5. 克隆仓库         git clone "url"
echo -- 6. 添加文件到暂存区 git add
echo -- 7. 提交暂存区的文件 git commit -m "文件名"
echo -- 8. 推送到远程仓库   git push origin master
echo -- 9. 取消缓存         git reset HEAD "!reset_file!"
echo -- 10.查看历史记录     git log "选项"
echo -- 11.查看更新详细信息 git diff
echo -- 12.生成git密钥      ssh-keygen -t rsa 
echo -- 13.远程仓库管理
echo -- 14.分支管理         q: 退出
echo ======================================================
setlocal enabledelayedexpansion
set /p choice=请输入选项：

if "!choice!"=="1" (
    echo 查看Git状态
    git status
) else if "!choice!"=="2" (
    echo 配置用户名-邮箱
    set /p user=请输入user.name：
    set /p email=请输入user.email：
    git config --global user.name "!user!"
    git config --global user.email "!email!"
) else if "!choice!"=="3" (
    echo 查询配置
    git config --global --list
) else if "!choice!"=="4" (
    echo 本地化
    git init
) else if "!choice!"=="5" (
    echo 克隆仓库
    set /p repository_url=请输入要克隆的仓库URL：
    git clone "!repository_url!"
)else if "!choice!"=="6" (
    echo 添加文件到暂存区
    set /p fileName=请输入要添加的文件（.表示所有）：
    git add "!fileName!"
)else if "!choice!"=="7" (
    echo 提交暂存区的文件
    set /p commit_message=请输入提交信息：
    git commit -m "!commit_message!"
)else if "!choice!"=="8" (
    echo 推送到远程仓库git push --force origin master
	set /p ch=请输入选项：1强制推送：
	if "!ch!"=="1" (
		git push --force origin master
	) else (
		git push origin master )
)  else if "!choice!"=="9" (
    echo 取消缓存
    set /p reset_file=请输入要取消缓存的文件（.表示所有）：
    git reset HEAD "!reset_file!"
) else if "!choice!"=="10" (
    echo 查看历史记录-git log
	echo --oneline         ：查看历史记录的简洁版本
	echo --graph           ：查看历史中什么时候出现了分支、合并
	echo --reverse         ：逆向显示所有日志
	echo --author="用户名" ：查找指定用户的提交日志
	echo --no-merges       ：以隐藏合并提交
	echo --since="y-m-d"   ：指定筛选日期  --before=""、--until、--after
	echo 例子：git log --oneline --author="用户名" --since="y-m-d" --before="y-m-d"

	set /p logs=请输入要后置选项（可以不填）：

	if not defined logs (
		set logs=--graph
	)

	git log "!logs!"
) else if "!choice!"=="11" (
    echo 查看更新的详细信息
    git diff
) else if "!choice!"=="12" (
    echo -》生成的密钥对可用于SSH连接、Git仓库的认证等场景。
    echo -》你可以将公钥（id_rsa.pub）提供给需要的服务或系统，以便进行身份验证。
    echo -》ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    echo -》-t id_rsa（私钥）和id_rsa.pub（公钥）
    echo -》-b 4096 用于指定密钥的位数或密钥长度
    set /p ssh_git=请输入git相关命令：
    call !ssh_git!
) else if "!choice!"=="13" (
    echo 远程仓库管理
    :remote_menu
	echo ------------------------------------------------------
    echo --》 1. 添加远程仓库     git remote add "remote_name!" "remote_url!"
    echo --》 2. 查看当前远程仓库 git remote
    echo --》 3. 提取远程仓库     git fetch "remote_name!"
    echo --》 4. 推送到远程仓库   git push "remote_name!" "remote_branch!"
    echo --》 5. 删除远程仓库     git remote rm "remote_name!"
    echo --》 0. 返回上级菜单
	echo ------------------------------------------------------

    set /p remote_choice=请选择远程仓库管理选项：

    if "!remote_choice!"=="1" (
        echo 添加远程仓库
        set /p remote_name=请输入远程仓库名称：
        set /p remote_url=请输入远程仓库URL：
        git remote add "!remote_name!" "!remote_url!"
    ) else if "!remote_choice!"=="2" (
        echo 查看当前远程仓库
        git remote
    ) else if "!remote_choice!"=="3" (
        echo 提取远程仓库
        set /p remote_name=请输入远程仓库名称：
        git fetch "!remote_name!"
    ) else if "!remote_choice!"=="4" (
        echo 推送到远程仓库
        set /p remote_name=请输入远程仓库名称：
        set /p remote_branch=请输入远程分支名称：
        git push "!remote_name!" "!remote_branch!"
    ) else if "!remote_choice!"=="5" (
        echo 删除远程仓库
        set /p remote_name=请输入要删除的远程仓库名称：
        git remote rm "!remote_name!"
    ) else if "!remote_choice!"=="0" (
        echo 返回上级菜单
        goto menu
    ) else (
        echo 无效的选项，请重新输入。
        pause
        goto remote_menu
    )

    pause
) else if "!choice!"=="14" (
    echo 分支管理
    :branch_menu
	echo ------------------------------------------------------
    echo --》 1. 查看分支  git branch
    echo --》 2. 创建分支  git branch "branch_name!"
    echo --》 3. 切换分支  git checkout "branch_name!"
    echo --》 4. 合并分支  git merge "branch_name!"
    echo --》 5. 删除分支  git branch -d "branch_name!"
    echo --》 0. 返回上级菜单
	echo ------------------------------------------------------

    set /p branch_choice=请选择分支管理选项：

    if "!branch_choice!"=="1" (
        echo 查看分支
        git branch
    ) else if "!branch_choice!"=="2" (
        echo 创建分支
        set /p branch_name=请输入分支名称：
        git branch "!branch_name!"
    ) else if "!branch_choice!"=="3" (
        echo 切换分支
        set /p branch_name=请输入分支名称：
        git checkout "!branch_name!"
    ) else if "!branch_choice!"=="4" (
        echo 合并分支
        set /p branch_name=请输入要合并的分支名称：
        git merge "!branch_name!"
    ) else if "!branch_choice!"=="5" (
        echo 删除分支
        set /p branch_name=请输入要删除的分支名称：
        git branch -d "!branch_name!"
    ) else if "!branch_choice!"=="0" (
        echo 返回上级菜单
        goto menu
    ) else (
        echo 无效的选项，请重新输入。
        pause
        goto branch_menu
    )

    pause
)else if "!choice!"=="q" (
    echo 退出
    exit
) else (
    echo 无效的选项，请重新输入。
    pause
    goto menu
)

endlocal
goto menu
