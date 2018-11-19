#include <omp.h>
#include <bits/stdc++.h>
#include <unistd.h>

omp_lock_t C;

int main() {

     int count;

     omp_init_lock(&C);
     omp_set_lock(&C);

     #pragma omp parallel
     {
          #pragma omp single nowait
          {
               printf("Hilo para liberar los candados cada 2 segundos lanzada.\n");
               for (int i = 0; i < omp_get_num_threads(); i++) 
               {
                    sleep(2);
                    omp_unset_lock(&C);   
               }
          }
          auto i = omp_get_thread_num();
          printf("Hilo %d esperando\n", i); 
          omp_set_lock(&C); 
          printf("Hilo %d completado\n", i); 

     }

     return 0;
}
