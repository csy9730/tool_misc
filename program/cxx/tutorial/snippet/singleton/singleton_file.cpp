#include <stdio.h>
#include <string.h>
#include <string>
#include <stdlib.h>

#ifdef __GNUC__
	#include <fcntl.h>
	#include <errno.h>

	#include <sys/file.h>
	#include <unistd.h>
#else
	#include "windows.h"
	#include "fileapi.h"
#endif

const static char* _g_progname = "singleton";
#ifdef __GNUC__
static int g_single_proc_inst_lock_fd = -1;

static void single_proc_inst_lockfile_cleanup(void)
{
	if (g_single_proc_inst_lock_fd != -1) {
		close(g_single_proc_inst_lock_fd);
		g_single_proc_inst_lock_fd = -1;
	}
}

// /var/tmp/singleton.lock will exist after program exit
bool is_single_proc_inst_running(const char *process_name)
{
	char lock_file[128];
	snprintf(lock_file, sizeof(lock_file), "/var/tmp/%s.lock", process_name);
	
	g_single_proc_inst_lock_fd = open(lock_file, O_CREAT|O_RDWR, 0644);
	if (-1 == g_single_proc_inst_lock_fd) {
		fprintf(stderr, "Fail to open lock file(%s). Error: %s\n",
			lock_file, strerror(errno));
		return false;
	}

	if (0 == flock(g_single_proc_inst_lock_fd, LOCK_EX | LOCK_NB)) {
		atexit(single_proc_inst_lockfile_cleanup);
		return true;
	}
	close(g_single_proc_inst_lock_fd);
	g_single_proc_inst_lock_fd = -1;
	return false;
} 
#else
	
bool is_single_proc_inst_running(const char *process_name){
	static HANDLE hMutex = CreateMutex(NULL, FALSE, "Global\\73E21C80-1960-472F-BF0B-3EE7CC7AF17E");

	DWORD dwError = GetLastError();

	if (ERROR_ALREADY_EXISTS == dwError || ERROR_ACCESS_DENIED == dwError)
	{
		return false;
	}
	return true;     
	// if (NULL != hMutex)CloseHandle(hMutex);
}
#endif

// demo:  my_exe sleep 5
// demo:  my_exe ping www.bing.com

// test on windows msvc2015, windows mingw64, ubuntu x86, 
int main(int argc, char** argv){
	if (argc>1){
		std::string s = argv[1];
		for(int i=2;i<argc;i++){
			s += ' ';
			s += argv[i];
		}
		printf("%d,%s\n", argc, s.c_str());
		if (is_single_proc_inst_running(_g_progname))
			return system(s.c_str());
		printf("failed\n");
		return -1;
	}
	printf("%d,%s\n", argc, argv[0]);
	return 0;
}