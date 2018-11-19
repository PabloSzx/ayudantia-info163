#include <omp.h>
#include <unistd.h>
#include <bits/stdc++.h>


int main() {
    #pragma omp parallel
    {

        auto i = omp_get_thread_num(); //c++11 / c++14
        printf("Hilo %d llamado\n", i);
        printf("Hilo %d trabajando\n", i);
        sleep(rand() % 10);
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