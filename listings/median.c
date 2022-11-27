#include <stdio.h>

void main() {
    int result = 0;
    int n = 8;
    int a[] = {10, 30, 56, 79, 47, 90, 100, 101};
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j] > a[j + 1]) {
                int t = a[j];
                a[j] = a[j + 1];
                a[j + 1] = t;
            }
        }
    }
    if (n % 2 == 0) {
        result = (a[n / 2 - 1] + a[n / 2]) / 2;
    } else {
        result = a[n / 2];
    }
    printf("%i", result);
}