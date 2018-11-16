#include <omp.h>
#include <bits/stdc++.h>

using namespace std;


int main() {
    #pragma omp parallel
    {
        #pragma omp taskloop
        for (int i = 0; i < omp_get_num_threads(); i++) {
            printf("i: %d, from: %d\n", i, omp_get_thread_num());
        }
    }

    return 0;

}