@echo off

:menu
echo ======================================================
echo -- 1. �鿴Git״̬      git status
echo -- 2. �����û���-����  git config --global user.
echo -- 3. ��ѯ����         git config --global --list
echo -- 4. ���ػ�����       git init
echo -- 5. ��¡�ֿ�         git clone "url"
echo -- 6. ����ļ����ݴ��� git add
echo -- 7. �ύ�ݴ������ļ� git commit -m "�ļ���"
echo -- 8. ���͵�Զ�ֿ̲�   git push origin master
echo -- 9. ȡ������         git reset HEAD "!reset_file!"
echo -- 10.�鿴��ʷ��¼     git log "ѡ��"
echo -- 11.�鿴������ϸ��Ϣ git diff
echo -- 12.����git��Կ      ssh-keygen -t rsa 
echo -- 13.Զ�ֿ̲����
echo -- 14.��֧����         q: �˳�
echo ======================================================
setlocal enabledelayedexpansion
set /p choice=������ѡ�

if "!choice!"=="1" (
    echo �鿴Git״̬
    git status
) else if "!choice!"=="2" (
    echo �����û���-����
    set /p user=������user.name��
    set /p email=������user.email��
    git config --global user.name "!user!"
    git config --global user.email "!email!"
) else if "!choice!"=="3" (
    echo ��ѯ����
    git config --global --list
) else if "!choice!"=="4" (
    echo ���ػ�
    git init
) else if "!choice!"=="5" (
    echo ��¡�ֿ�
    set /p repository_url=������Ҫ��¡�Ĳֿ�URL��
    git clone "!repository_url!"
)else if "!choice!"=="6" (
    echo ����ļ����ݴ���
    set /p fileName=������Ҫ��ӵ��ļ���.��ʾ���У���
    git add "!fileName!"
)else if "!choice!"=="7" (
    echo �ύ�ݴ������ļ�
    set /p commit_message=�������ύ��Ϣ��
    git commit -m "!commit_message!"
)else if "!choice!"=="8" (
    echo ���͵�Զ�ֿ̲�git push --force origin master
	set /p ch=������ѡ�1ǿ�����ͣ�
	if "!ch!"=="1" (
		git push --force origin master
	) else (
		git push origin master )
)  else if "!choice!"=="9" (
    echo ȡ������
    set /p reset_file=������Ҫȡ��������ļ���.��ʾ���У���
    git reset HEAD "!reset_file!"
) else if "!choice!"=="10" (
    echo �鿴��ʷ��¼-git log
	echo --oneline         ���鿴��ʷ��¼�ļ��汾
	echo --graph           ���鿴��ʷ��ʲôʱ������˷�֧���ϲ�
	echo --reverse         ��������ʾ������־
	echo --author="�û���" ������ָ���û����ύ��־
	echo --no-merges       �������غϲ��ύ
	echo --since="y-m-d"   ��ָ��ɸѡ����  --before=""��--until��--after
	echo ���ӣ�git log --oneline --author="�û���" --since="y-m-d" --before="y-m-d"

	set /p logs=������Ҫ����ѡ����Բ����

	if not defined logs (
		set logs=--graph
	)

	git log "!logs!"
) else if "!choice!"=="11" (
    echo �鿴���µ���ϸ��Ϣ
    git diff
) else if "!choice!"=="12" (
    echo -�����ɵ���Կ�Կ�����SSH���ӡ�Git�ֿ����֤�ȳ�����
    echo -������Խ���Կ��id_rsa.pub���ṩ����Ҫ�ķ����ϵͳ���Ա���������֤��
    echo -��ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    echo -��-t id_rsa��˽Կ����id_rsa.pub����Կ��
    echo -��-b 4096 ����ָ����Կ��λ������Կ����
    set /p ssh_git=������git������
    call !ssh_git!
) else if "!choice!"=="13" (
    echo Զ�ֿ̲����
    :remote_menu
	echo ------------------------------------------------------
    echo --�� 1. ���Զ�ֿ̲�     git remote add "remote_name!" "remote_url!"
    echo --�� 2. �鿴��ǰԶ�ֿ̲� git remote
    echo --�� 3. ��ȡԶ�ֿ̲�     git fetch "remote_name!"
    echo --�� 4. ���͵�Զ�ֿ̲�   git push "remote_name!" "remote_branch!"
    echo --�� 5. ɾ��Զ�ֿ̲�     git remote rm "remote_name!"
    echo --�� 0. �����ϼ��˵�
	echo ------------------------------------------------------

    set /p remote_choice=��ѡ��Զ�ֿ̲����ѡ�

    if "!remote_choice!"=="1" (
        echo ���Զ�ֿ̲�
        set /p remote_name=������Զ�ֿ̲����ƣ�
        set /p remote_url=������Զ�ֿ̲�URL��
        git remote add "!remote_name!" "!remote_url!"
    ) else if "!remote_choice!"=="2" (
        echo �鿴��ǰԶ�ֿ̲�
        git remote
    ) else if "!remote_choice!"=="3" (
        echo ��ȡԶ�ֿ̲�
        set /p remote_name=������Զ�ֿ̲����ƣ�
        git fetch "!remote_name!"
    ) else if "!remote_choice!"=="4" (
        echo ���͵�Զ�ֿ̲�
        set /p remote_name=������Զ�ֿ̲����ƣ�
        set /p remote_branch=������Զ�̷�֧���ƣ�
        git push "!remote_name!" "!remote_branch!"
    ) else if "!remote_choice!"=="5" (
        echo ɾ��Զ�ֿ̲�
        set /p remote_name=������Ҫɾ����Զ�ֿ̲����ƣ�
        git remote rm "!remote_name!"
    ) else if "!remote_choice!"=="0" (
        echo �����ϼ��˵�
        goto menu
    ) else (
        echo ��Ч��ѡ����������롣
        pause
        goto remote_menu
    )

    pause
) else if "!choice!"=="14" (
    echo ��֧����
    :branch_menu
	echo ------------------------------------------------------
    echo --�� 1. �鿴��֧  git branch
    echo --�� 2. ������֧  git branch "branch_name!"
    echo --�� 3. �л���֧  git checkout "branch_name!"
    echo --�� 4. �ϲ���֧  git merge "branch_name!"
    echo --�� 5. ɾ����֧  git branch -d "branch_name!"
    echo --�� 0. �����ϼ��˵�
	echo ------------------------------------------------------

    set /p branch_choice=��ѡ���֧����ѡ�

    if "!branch_choice!"=="1" (
        echo �鿴��֧
        git branch
    ) else if "!branch_choice!"=="2" (
        echo ������֧
        set /p branch_name=�������֧���ƣ�
        git branch "!branch_name!"
    ) else if "!branch_choice!"=="3" (
        echo �л���֧
        set /p branch_name=�������֧���ƣ�
        git checkout "!branch_name!"
    ) else if "!branch_choice!"=="4" (
        echo �ϲ���֧
        set /p branch_name=������Ҫ�ϲ��ķ�֧���ƣ�
        git merge "!branch_name!"
    ) else if "!branch_choice!"=="5" (
        echo ɾ����֧
        set /p branch_name=������Ҫɾ���ķ�֧���ƣ�
        git branch -d "!branch_name!"
    ) else if "!branch_choice!"=="0" (
        echo �����ϼ��˵�
        goto menu
    ) else (
        echo ��Ч��ѡ����������롣
        pause
        goto branch_menu
    )

    pause
)else if "!choice!"=="q" (
    echo �˳�
    exit
) else (
    echo ��Ч��ѡ����������롣
    pause
    goto menu
)

endlocal
goto menu
