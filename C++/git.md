# 杂七杂八
## SSL
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names.


# 指令
## log 

| 选项                    | 作用               |
| --------------------- | ---------------- |
| --oneline             | 每个提交缩略为一行（哈希+标题） |
| --graph               | 显示分支合并图（ASCII图）  |
| --all                 | 显示所有分支的历史        |
| -n <数字>               | 限制显示最近 n 条提交     |
| --author="名字"         | 过滤特定作者的提交        |
| --since="2025-10-01"  | 显示某日期之后的提交       |
| --pretty=format:"..." | 自定义输出格式          |
## 1. 配置 & 初始化 

| 任务 | 命令样板 | 
|---|---| 
| 首次全局配置 | `git config --global user.name "你的名字"`<br>`git config --global user.email "you@xxx.com"` |
| 颜色开关 | `git config --global color.ui auto` | 
| 当前仓库配置 | 去掉 `--global` 即可，只对 `.git/config` 生效 | 
| 初始化仓库 | `git init` # 当前目录新建 `.git` | 
| 克隆 | `git clone <url> [目录名] --depth 1` # `--depth 1` 只拉最新一次提交，省流量 |
    

---

## 2. 日常三件套（工作区 → 暂存区 → 版本库）

| 任务 | 命令样板 |
|---|---|
| 查看状态 | `git status -sb` # `-s` 简洁，`-b` 显示分支 |
| 添加文件 | `git add -A` # 所有变化（新增、修改、删除）一次性加入暂存区 |
| 提交 | `git commit -m "描述"`&lt;br&gt;`git commit -v -a` # `-a` 自动把已跟踪文件的修改加入暂存区，`-v` 在编辑器里显示 diff |
| 跳过暂存直接提交已跟踪文件 | `git commit -am "描述"` |

---

## 3. 日志 & diff

| 任务 | 命令样板 |
|---|---|
| 简洁历史 | `git log --oneline -n 20 --graph --all` |
| 查某文件历史 | `git log -p --follow 文件名` # `-p` 带 diff，`--follow` 追踪重命名 |
| 某作者 | `git log --author="alice" --since="2025-10-01"` |
| 区间对比 | `git log master..feature` # 只显示 feature 独有提交 |
| 工作区 vs 暂存区 | `git diff` |
| 暂存区 vs HEAD | `git diff --cached`（旧写法 `--staged`） |
| 工作区 vs HEAD | `git diff HEAD` |

---

## 4. 撤销 & 回退

| 任务 | 命令样板 |
|---|---|
| 改坏工作区，还没 add | `git checkout -- 文件名` # 还原到 HEAD 版本 |
| 已 add 想撤出暂存区 | `git reset HEAD 文件名` |
| 提交错，仅重写提交信息 | `git commit --amend -m "新描述"` |
| 提交错，想撤回提交但保留修改 | `git reset --soft HEAD^` |
| 提交错，想撤回提交并丢弃修改 | `git reset --hard HEAD^` **危险！** |
| 远程已 push，安全回退 | `git revert &lt;commit&gt;` # 新增一次“反提交”，历史不删 |

---

## 5. 分支 & 合并

| 任务 | 命令样板 |
|---|---|
| 查看分支 | `git branch -a` # `-r` 只看远程，`-vv` 显示跟踪关系 |
| 新建并切换 | `git checkout -b feature`&lt;br&gt;或 `git switch -c feature`（Git ≥ 2.23） |
| 切换已有分支 | `git switch master` |
| 删除本地分支 | `git branch -d feature` # `-D` 强制 |
| 删除远程分支 | `git push origin --delete feature` |
| 合并 | `git merge feature --no-ff` # `--no-ff` 保留分支拓扑 |
| 变基（线性历史） | `git rebase -i HEAD~3` # 交互式整理最近 3 条提交 |
| 中止变基 | `git rebase --abort` |
| 继续变基 | `git rebase --continue` |

---

## 6. 远程同步

| 任务         | 命令样板                                                    |
| ---------- | ------------------------------------------------------- |
| 第一次推远程     | `git push -u origin master` # `-u` 建立跟踪，后续直接 `git push` |
| 常规推送       | `git push`                                              |
| 强推（**危险**） | `git push --force-with-lease` # 比 `--force` 安全，会检查冲突    |
| 获取并自动合并    | `git pull --rebase` # 用 rebase 方式拉，历史更线性                |
| 仅获取不合并     | `git fetch -p` # `-p` prune，自动清理已删远程分支                  |
| 查看远程地址     | `git remote -v`                                         |
| 添加第二个远程    | `git remote add upstream &lt;url&gt;`                   |

---

## 7. 标签

| 任务 | 命令样板 |
|---|---|
| 轻量标签 | `git tag v1.0.0` |
| 附注标签 | `git tag -a v1.0.0 -m "发布说明"` |
| 推送标签 | `git push origin v1.0.0`&lt;br&gt;`git push origin --tags` # 一次性推全部 |
| 删除远程标签 | `git push origin --delete tag v1.0.0` |

---

## 8. 暂存（工作区打断）

| 任务 | 命令样板 |
|---|---|
| 临时保存 | `git stash push -m "wip"` |
| 列表 | `git stash list` |
| 弹出并应用 | `git stash pop` |
| 仅应用不删 | `git stash apply stash@{2}` |
| 丢弃 | `git stash drop stash@{0}` |

---

## 9. 子模块 & 大文件（了解）

| 任务 | 命令样板 |
|---|---|
| 添加子模块 | `git submodule add &lt;url&gt; path` |
| 初始化并拉子模块 | `git submodule update --init --recursive` |
| 大文件托管 | `git lfs track "*.psd"` → `git add .gitattributes` |

---

## 10. 调试 & 找 bug

| 任务 | 命令样板 |
|---|---|
| 二分查找 | `git bisect start`&lt;br&gt;`git bisect bad` # 当前版本有问题&lt;br&gt;`git bisect good v1.0.0` # 已知旧版本没问题&lt;br&gt;自动 checkout 中间提交，测完再 `git bisect good/bad`，直至定位 |
| 一行代码谁改的 | `git blame 文件名 -L 50,60` |

---

## 11. 别名（提速）

```bash
git config --global alias.co   checkout
git config --global alias.br   branch
git config --global alias.st   status -sb
git config --global alias.lg   "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d %s %Cgreen(%cr) %C(bold blue)&lt;%an&gt;%Creset' --abbrev-commit"