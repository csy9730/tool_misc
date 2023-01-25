cygwin=false;
darwin=false;
mingw=false;
linux=false;

parse_uname_os(){
    case "`uname -s`" in
    CYGWIN*) 
        echo "cygwin"
        cygwin=true ;;
    MINGW*) 
        echo "mingw"
        mingw=true;;
    Linux*) 
        echo "Linux"
        linux=true
        ;;
    Darwin*) 
        echo "darwin"
        darwin=true
        ;;
    *)  
        echo "os not found"  
            ;;  
    esac
}



x86=false
x86_64=false
aarch64=false
armv7l=false
parse_uname_mac(){
    case "`uname -m`" in
    x86_64*) 
        echo "x86_64"
        x86_64=true ;;
    x86*) 
        echo "x86"
        x86=true ;;
    armv7l*) 
        echo "armv7l"
        armv7l=true;;
    aarch64*) 
        echo "aarch64"
        aarch64=true
        ;;
    *)  
        echo "machine not found"  
        ;;  
    esac
}

parse_uname_os
parse_uname_mac

if $linux; then echo "os is linux"; else echo "os is not linux"; fi