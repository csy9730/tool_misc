#
# 获取 Shell.Application 代理
# 
function Get-ShellProxy
{
  if( -not $global:ShellProxy) { 
  $global:ShellProxy = new-object -com Shell.Application
  }
  $global:ShellProxy
}
  
#
# 查看 Shell 项
# 
function Get-ShellItem
{
 param($Path=17)
 $shell=Get-ShellProxy
 
 # 默认的 NameSpace()方法只支持目录，不支持文件
 # 为了增强兼容性和保持一致性，如果传入一个文件路径，可以尝试通过文件路径获取目录，然后再从目录的子项中获取Shell项
 trap [System.Management.Automation.MethodInvocationException]
 {
  $Path = $Path.ToString()
  $dir = $Path.Substring( 0 ,$Path.LastIndexOf('\') )
  return $shell.NameSpace($dir).items()  | 
   where { (-not $_.IsFolder ) -and  $_.path -eq $Path} |
   select -First 1
  continue
 }
 $shell.NameSpace($Path).self
}
  
#
# 查看 Shell 子项,支持递归和过滤
# 
function Get-ChildShellItem
{
 param(
  $Path=17,
  [switch]$Recurse,
  $Filter=$null)
 
 #内部过滤器
 Filter myFilter
 {
   if($Filter){
   $_ | where { $_.Name -match $Filter }
   }
   else{
   $_
   }
 }
 
 $shellItem = Get-ShellItem $Path
 $shellItem | myFilter
 # 如果是目录
 if( $shellItem.IsFolder ){ 
  # 如果指定递归
  if($Recurse) {
   $shellItem | myFilter
   $stack=New-Object System.Collections.Stack
   # 当前目录压入堆栈
   $stack.Push($shellItem)
   while($stack.Count -gt 0)
   {
     # 访问栈顶元素
     $top = $stack.Pop()
     $top | myFilter
 
     # 访问栈顶元素的子元素
     $top.GetFolder.items() | foreach {
       if( $_.IsFolder )
       { $stack.Push($_) }
       else { $_ | myFilter }
     }
   }
  }
  else{
  $shellItem.GetFolder.items() | myFilter }
  }
}
 
#
# 复制Shell项
#
function Copy-ShellItem
{
 param($Path,$Destination)
 $shell=Get-ShellProxy
 $shell.NameSpace($Destination).Copyhere($Path,16)
}
 
#
# 删除Shell项
#
function Remove-ShellItem
{
 param($Path)
 $ShellItem = Get-ShellItem $Path
 $ShellItem.InvokeVerb('delete')
}
 
#
# 移动Shell项
#
function Move-ShellItem
{
 param($Path,$Destination)
 $shell=Get-ShellProxy
 $shell.NameSpace($Destination).MoveHere($Path,16)
}