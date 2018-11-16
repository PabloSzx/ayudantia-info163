#include <omp.h>
#include <bits/stdc++.h>

using namespace std;

int recurso = 100;

void reservado(int i) {
    cout << "\nDesde el hilo " << i << " ahora me queda " << --recurso << " de recurso\n\n";
}

int main() {
    srand(time(NULL));


    #pragma omp parallel
    {
        printf("Hilo %d llamado\n", omp_get_thread_num());
        #pragma omp critical
            reservado(omp_get_thread_num());
    }

    return 0;
}