#include <stdio.h>

void pointer_add()
{
    int a[] = {0, 2, 4, 6, 8};
    int *p = a;
    printf("%x,%d\n", p + 1, *p + 1);
    printf("%x,%d\n", p, *p++);
    printf("%x,%d\n", p, *++p);
}

void twoDimensionArray()
{
#define M (3)
#define N (4)
    int arr[M][N] = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
    int *p = (int *)arr;
    // M*N*sizeof(int), N*sizeof(int), sizeof(int)
    printf("%d,%d,%d\n", sizeof(arr), sizeof(*arr), sizeof(**arr));

    printf("%x,%x,%x\n", arr, *arr, &arr);
    printf("%x,%x,%x\n", arr, arr + 2, (*(arr + 2)) + 1);
    printf("%x,%x\n", **arr, arr[0][0]);
    printf("%d,%d,%d,%d,%d\n", *(arr[2] + 1),(*(arr + 2))[1], *(*(arr + 2) + 1), arr[2][1], *(p + N * 2 + 1));

    int **pptr = (int **)arr;
    printf("%x,%x\n", pptr, *(pptr + 2));
    // printf("%x\n",**pptr); // terminated
}

void arrayPointer()
{
    int arr[10] = {
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
    };
    int(*arrPtr)[10] = arr;
    printf("%x,%x,%x\n", &arrPtr, arrPtr, *arrPtr);
    printf("%d,%d,%d\n", sizeof(arrPtr), sizeof(*arrPtr), sizeof(**arrPtr));
    printf("%x,%x\n", *(*arrPtr) + 3, (*arrPtr)[3]);
}

void pointerArrayDemo()
{
#define M (3)
    int arr[] = {0, 1, 2};
    int arr2[] = {3, 4, 5, 6};
    int arr3[] = {7, 8, 9, 10, 11};
    int *ptrArr[M] = {arr, arr2, arr3};

    printf("%d,%d\n", sizeof(ptrArr), sizeof(*ptrArr));
    printf("%x,%x,%x\n", &ptrArr, ptrArr, *ptrArr);
    printf("%x,%x,%x,%x\n", ptrArr[1][2], *ptrArr[1] + 2, *(*ptrArr + 1) + 2, (*ptrArr + 1)[2]);
}

int main()
{
    twoDimensionArray();
    // pointer_add();
    // arrayPointer();
    // pointerArrayDemo();
}
