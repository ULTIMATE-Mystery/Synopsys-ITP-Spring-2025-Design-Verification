// Author: Christian Stangier
// Date: March 2016
// Description: C program for debugging grid issues

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
int main(int argc, char *argv[])
{

    unsigned GB = 1;
    unsigned extra_time = 0;
    if (argc > 1 ){
        GB = atoi(argv[1]);
    }
    
    if (argc > 2 ){
        extra_time = atoi(argv[2]);
    }
    
    unsigned long long big_num = 1024 * 128 * 1024 * GB;
    long *big_array;
    unsigned long long sum = 0;
    printf(" Hello world!\n");
    printf(" Testing memory usage of %ld Mbytes\n", big_num * sizeof(long) / 1024 /1024);
    big_array = malloc( big_num * sizeof(long));
    for (unsigned long long i = 0 ; i < big_num ; i++){
        big_array[i] =1 ;
    }

    for (unsigned long long i = 0 ; i < big_num ; i++){
        sum += big_array[i];
    }
    if ( sum != big_num){
        printf("Failure! %lld neq %lld\n", sum, big_num );
        return 1;
    } else {
        if(extra_time){
            printf(" Do something for %d secs...\n", extra_time);
            clock_t startTime = clock();         
            clock_t t;
            do {
                // spend some time doing something
                for(unsigned j = 0; j < 10; j++){
                    for (unsigned long long i = 0 ; i < (1000 * 1000 * 100) ; i++){
                        if( big_array[i] == 2){
                            printf(" Now that's interesting\n");
                            return 1;
                        }
                    }
                }
                clock_t endTime = clock();
                t = endTime - startTime;
                printf ("   It took me %d clicks (%f seconds).\n",t,((float)t)/CLOCKS_PER_SEC);
            } while  ( ((float)t)/CLOCKS_PER_SEC < (float)extra_time);
        }
       
        
        printf("Success!\n");
        return 0;
    }
}
