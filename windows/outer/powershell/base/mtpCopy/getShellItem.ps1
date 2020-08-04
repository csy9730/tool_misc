#
# ��ȡ Shell.Application ����
# 
function Get-ShellProxy
{
  if( -not $global:ShellProxy) { 
  $global:ShellProxy = new-object -com Shell.Application
  }
  $global:ShellProxy
}
  
#
# �鿴 Shell ��
# 
function Get-ShellItem
{
 param($Path=17)
 $shell=Get-ShellProxy
 
 # Ĭ�ϵ� NameSpace()����ֻ֧��Ŀ¼����֧���ļ�
 # Ϊ����ǿ�����Ժͱ���һ���ԣ��������һ���ļ�·�������Գ���ͨ���ļ�·����ȡĿ¼��Ȼ���ٴ�Ŀ¼�������л�ȡShell��
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
# �鿴 Shell ����,֧�ֵݹ�͹���
# 
function Get-ChildShellItem
{
 param(
  $Path=17,
  [switch]$Recurse,
  $Filter=$null)
 
 #�ڲ�������
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
 # �����Ŀ¼
 if( $shellItem.IsFolder ){ 
  # ���ָ���ݹ�
  if($Recurse) {
   $shellItem | myFilter
   $stack=New-Object System.Collections.Stack
   # ��ǰĿ¼ѹ���ջ
   $stack.Push($shellItem)
   while($stack.Count -gt 0)
   {
     # ����ջ��Ԫ��
     $top = $stack.Pop()
     $top | myFilter
 
     # ����ջ��Ԫ�ص���Ԫ��
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
# ����Shell��
#
function Copy-ShellItem
{
 param($Path,$Destination)
 $shell=Get-ShellProxy
 $shell.NameSpace($Destination).Copyhere($Path,16)
}
 
#
# ɾ��Shell��
#
function Remove-ShellItem
{
 param($Path)
 $ShellItem = Get-ShellItem $Path
 $ShellItem.InvokeVerb('delete')
}
 
#
# �ƶ�Shell��
#
function Move-ShellItem
{
 param($Path,$Destination)
 $shell=Get-ShellProxy
 $shell.NameSpace($Destination).MoveHere($Path,16)
}