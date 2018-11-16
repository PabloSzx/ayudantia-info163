#include <omp.h>
#include <bits/stdc++.h>
#include <unistd.h>

using namespace std;


int main() {
    srand(time(NULL));

    //omp_set_num_threads(20); 
    #pragma omp parallel
    {
        auto i = omp_get_thread_num();
        printf("Hilo %d llamado\n", i);
        #pragma omp task 
        {
            printf("NRAND: %d, desde el hilo: %d, %d\n", rand() % 100, i, omp_get_thread_num());
            usleep(rand()%10000000);
            printf("Hilo %d terminado\n",i);
        }
        printf("Fuera del task desde el hilo:  %d\n", i);
    }

    printf("\n\n\n\n");

    #pragma omp parallel
    {
        auto i = omp_get_thread_num();
        printf("Hilo %d llamado\n", i);
        printf("NRAND: %d, desde el hilo: %d, %d\n", rand() % 10, i, omp_get_thread_num());
    }


    return 0;
}