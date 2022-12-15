#include "stdlib.h"
#include "stdio.h"

int get_compiler(){
    
    #ifdef __GNUC__
        printf("gcc");
        
        #ifdef __WIN32 
            #ifdef __MSYS__
                printf("__MSYS__");
            #elif __CYGWIN__
                printf("__CYGWIN__");
            #endif
        #endif

    #elif __MSC_VER
        printf("msvc");
    #elif __BORLANDC__
        printf("borlandc");
    #endif
    return 0;
}

int get_os(){

#ifdef _WIN32
   //define something for Windows (32-bit and 64-bit, this part is common)
   #ifdef _WIN64
      //define something for Windows (64-bit only)
      printf("win64");
   #else
      //define something for Windows (32-bit only)
      printf("win32");
   #endif
#elif __APPLE__
    #include "TargetConditionals.h"
    #if TARGET_IPHONE_SIMULATOR
         // iOS Simulator
    #elif TARGET_OS_IPHONE
        // iOS device
    #elif TARGET_OS_MAC
        // Other kinds of Mac OS
    #else
    #   error "Unknown Apple platform"
    #endif
#elif __ANDROID__
    printf("android");
#elif __linux__
    printf("linux");
#elif __unix__ // all unices not caught above
    // Unix
    printf("Unix");
#elif defined(_POSIX_VERSION)
    // POSIX
#else
#   error "Unknown compiler"
#endif
    return 0;
}

int main(int argc, char** argv){
    get_os();
    get_compiler();
}