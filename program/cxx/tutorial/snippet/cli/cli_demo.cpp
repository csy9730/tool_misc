#include <iostream>
#include <fstream>
#include <math.h>
#include <stdio.h>
#include <sys/time.h>
#include "string.h"
#include "file_utils.h"

using namespace std;
using namespace cv;

static const char* _ = "";
static const char* output_img = "save.png";
static const char* execute_name = "./forward_demo";

typedef struct _ZalParams_t{
    unsigned char is_no_save = 0; 
    unsigned char is_file_list = 0; 
    unsigned char use_rknn = 0; 
    unsigned char use_padding = 0; 
    unsigned char is_verbose = 0; 

    int batch_size = 1; 
    int is_chw = 0; 
    float thresh = 0.5; 
    // char _result[20] = "";
    char *arch = (char*) _;
    char *output =  (char*) output_img;
    char *network_cfg =  (char*) _;
}_ZalParams;

_ZalParams params;

int printVersion(int argc, char **argv){
    cout<< "forward_demo: image forward demo tool\n"
            << "version 1.0.1\n"
            << "create by csy on 2021/06/09\n"
            << "license by ABC\n";
    return 0;
}

int printHelp(int argc, char **argv){
    cout << "./forward_demo  --version\n"
        <<"./forward_demo  --show  model_name\n"
        << "./forward_demo  --list  model_name\n"
        << "./forward_demo  --rknn-strings  model_name\n"
        << "./forward_demo  test.jpg  model_name(switches.abc) " << endl;
    return 0;
}

int showIncomplete(int argc, char **argv){
    cout << "this function is incomplete" << endl;
    return 0;
}

int showMeta(int argc, char **argv){
    std::string zal_predictor_getmeta(const char *path);
    cout<< zal_predictor_getmeta(argv[1]);
    return 0;
}

int abcListContent(int argc, char **argv){
    char** titles = (char**)malloc(12 * sizeof(char*));
    for (int i=0;i<12;i++){
        titles[i] = (char*) malloc(sizeof(char)*50);
    }
    int tlen = zal_forward_impl_list(argv[1], titles);
    for (int i=0;i<tlen;i++){
        cout<<i<<','<< titles[i]<<'\t';
    }
    cout<<endl;
	free(titles);
    return 0;
}
int rknnStrings(int argc, char **argv){
    char s[200] = "strings ";
    strcat(s, argv[1]);
    strcat(s, " |grep version");
    cout<<s<<endl;
    system(s);
    return 0;
}


int runForward(int argc,char **argv);


int main(int argc,char **argv)
{
    if(argc == 2){

    }else if(strcmp(argv[1], "-V")==0 || strcmp(argv[1], "--version")==0)
    {
        return printVersion(argc-1, argv+1);
    }else if(argc == 3 && strcmp(argv[1], "--show")==0)
    {
        return showMeta(argc-1, argv+1);
    }else if(strcmp(argv[1], "--rknn-strings")==0)
    {
        if (argc == 3)
            return showIncomplete(argc-1, argv+1);///
    }else if(strcmp(argv[1], "--list")==0)
    {
        if (argc == 3)
            return showIncomplete(argc-1, argv+1);///
    }
    else if(argc >= 2){
        return runForward(argc-1, argv+1);
    }
    return printHelp(argc-1, argv+1);
    
}


int parse_params(int argc,char** argv){
    int i;
    while (i < argc){
        if(0 == strcmp(argv[i], "--use-rknn")) {
            params.use_rknn = 1;
        }
        else if(0 == strcmp(argv[i], "--batch-size")) {
            i++;
            if (i>=argc){
                return 1;
            }
            params.batch_size = atoi(argv[i]);
        }
        else if(0 == strcmp(argv[i], "--thresh")) {
            i++;
            if (i>=argc){
                return 1;
            }
            params.thresh = atof(argv[i]);
        }else if(0 == strcmp(argv[i], "--arch")) {
            i++;
            if (i>=argc){
                return 1;
            }
            // strcpy(params.arch, argv[i]);
            params.arch = argv[i];
        }else if(0 == strcmp(argv[i], "--use-padding")) {
            params.use_padding = 1;
        }else if(0 == strcmp(argv[i], "--output") or 0 == strcmp(argv[i], "-o")) {
            i++;
            if (i>=argc){
                return 1;
            }
            params.output = argv[i];
        }else if(0 == strcmp(argv[i], "--file-list")) {
            params.is_file_list = 1;
        }else if(0 == strcmp(argv[i], "--no-save")) {
            params.is_no_save = 1;
        }else if(0 == strcmp(argv[i], "--network-cfg") or 0 == strcmp(argv[i], "-nc")) {
            i++;
            if (i>=argc){
                return 1;
            }
            params.network_cfg = argv[i];
        }else if(0 == strcmp(argv[i], "--verbose") or 0 == strcmp(argv[i], "-v")) {
            params.is_verbose = 1;
        }
        i++;
    }
    return 0;
}

int runForward(int argc,char **argv){
    int ret=0;
    char *model_path;
    const char * MODEL_PATH_DEFAULT = "./switches.abc";
    if(argc <= 1){
        model_path = (char*) MODEL_PATH_DEFAULT;
    }else{
        model_path = argv[1];
    }

    vector<string> files;

    if (is_file_exist(argv[0])){
        files.push_back(argv[0]);
    }else{
        cout<<"getFiles\n";
        getFiles(argv[0], files);
    }

    if (argc>=2){
        printf("use parse_params\n");
        parse_params(argc-2, argv+2);

        if (params.is_verbose){
            printf("model_path=%s\n", model_path);
            printf("--use-rknn=%d\n", params.use_rknn);
            printf("--use-padding=%d\n", params.use_padding);
            printf("--batch-size=%d\n", params.batch_size);
            printf("--thresh=%f\n", params.thresh);
            printf("--arch=%s\n", params.arch);
            printf("--output=%s\n", params.output);
            printf("--file-list=%d\n", params.is_file_list);
            printf("--no-save=%d\n", params.is_no_save);
            printf("--network-cfg=%s\n", params.network_cfg);
            printf("--verbose=%s\n", params.is_verbose);
        }
    }
    return 0;
}
