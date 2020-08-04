set bc="C:\Program Files\Beyond Compare 4\BCompare.exe"
set bc="D:\GreenSoftware\Beyond Compare 2\BC2.exe"
git config --global diff.tool bc2
git config --global difftool.prompt false
git config --global difftool.bc2.cmd '"D:\GreenSoftware\Beyond Compare 2\BC2.exe" "$LOCAL" "$REMOTE"'

git config --global merge.tool bc2
git config --global mergetool.prompt false
git config --global mergetool.bc2.cmd '"D:\GreenSoftware\Beyond Compare 2\BC2.exe" "$LOCAL" "$REMOTE" "$BASE" "$MERGED"'
git config --global mergetool.bc2.trustexitcode true