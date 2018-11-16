#include <omp.h>
#include <unistd.h>
#include <bits/stdc++.h>

using namespace std;


int main() {
    #pragma omp parallel
    {
        auto i = omp_get_thread_num();
        printf("Hilo %d llamado\n", i);
        printf("Hilo %d trabajando\n", i);
        usleep(rand() % 10000000);
        printf("Hilo %d listo\n", i);
        #pragma omp barrier
        printf("Hilo %d listo junto con su equipo\n", i);

        #pragma omp single
        {
            printf("Todos los hilos completados, el hilo que imprime esto es: %d\n", i);
        }


    }

    return 0;
}