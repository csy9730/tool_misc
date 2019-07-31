import os
def fOswalk(pth):
    for root,dirs,files in os.walk(pth):
        for filename in files:
            if filename.split('.')[-1]=='py':
                print(filename)
        break
        if len(dirs)>0:
            print( *dirs)
def fGitbookSummery(pth): 
    pth = pth.replace('\\','/')   
    for root,dirs,files in os.walk(pth):
        with open(os.getcwd()+'/summary.md','a+') as fp:
            for filename in files:
                if filename.split('.')[-1]=='py' and filename!='summary.md':
                    fp.write(' * %s\n'% (root+'/'+filename))


if __name__== "__main__":
    import sys
    if len(sys.argv)>1:
        pth = sys.argv[1]
    else:
        pth = r"."
    print(pth)
    print(sys.path[0])
    fGitbookSummery(pth)