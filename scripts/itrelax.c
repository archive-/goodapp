/*
 * TEAM NULL (c) 2012
 * compile: gcc -O3 -o itrelax itrelax.c
 *
 * Performs iterative relaxation algorithm
 * on a sparse matrix represented in a file.
 *
 * (uses the Gauss-Siedel method)
 *
 * eqn: F_n(k) = ((k_0^n + k_1^n + ... + k_j^n) / j)^(1/n)
 */

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    FILE *f;

    if (argc < 2) {
        fprintf(stderr, "usage: ./itrelax [FILE]\n");
        exit(1);
    }

    f = fopen(argv[1], "r");
    if (f == NULL) {
        perror(argv[1]);
        exit(1);
    }

    /* TODO read file */

    return 0;
}
