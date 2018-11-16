#include <omp.h>
#include <bits/stdc++.h>

using namespace std;


int main() {
    #pragma omp parallel
    {
		#pragma omp sections
		{
			#pragma omp section
			{
				for (int i = 0; i < 100; i++) {
					cout << i << endl;
				}
			}
			#pragma omp section
			{
				for (int i = 0; i < 100; i++) {
					cout << i << endl;
				}
			}
			#pragma omp section
			{
				for (int i = 0; i < 100; i++) {
					cout << i << endl;
				}
			}
			#pragma omp section
			{
				for (int i = 0; i < 100; i++) {
					cout << i << endl;
				}
			}    
		}
    }


    return 0;
}