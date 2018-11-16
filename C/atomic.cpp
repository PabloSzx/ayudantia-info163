#include <omp.h>
#include <bits/stdc++.h>

using namespace std;


int main() {

    srand(time(NULL));
    vector<int> numeros(3, 0);
    auto sum = 0;
    #pragma omp parallel shared(numeros) reduction(+: sum)
    {
        auto a =  rand() % 10 + 1;
        sum += a;
        auto b = rand()%numeros.size();
        printf("Desde thread: %d, %d %d\n", omp_get_thread_num(), b, a);
        #pragma omp atomic read
            numeros[b] = a;
    }


    for (auto i: numeros) {
        cout << i << endl;
    }
    cout << "Suma: " << sum << endl;


    return 0;
}