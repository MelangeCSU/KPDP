/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
//#include <smmintrin.h>
#include <string.h>
#include "timer.h"
#include "my_papi.h"
#include "immintrin.h"

#define MAX(a,b) ((a)>(b)?(a):(b))

#ifdef OMP
#include <omp.h>
#endif

//#define IN 10000
////#define N 27777770
//sun 20
////#define C 1152

void oneThread(int threadId);
void *mykernel(void *nothing);
int max_of_array(int *a, int length);

int tds;
int *w;
int *p;
int N;
int C;

int *cur, *pre;
int **comb;

int c_per_thread, c_per_first_thread;

int w_max;

int main (int argc, char** argv) 
{
	tds = 1;
	N = 17777770;
	C = 1152;

/*
	if (argv > 1) {
		tds = atoi(argc[1]);
	}
	if (argv > 2) {
		wi = atoi(argc[2]);
	}
	if (argv > 3) {
		pi = atoi(argc[3]);
	}
	if (argv > 3) {
		C = atoi(argc[4]);
	}
	if (argv > 4) {
		N = atoi(argc[5]);
	}
	c = (int *)_mm_malloc(sizeof(int)*C*tds, 32);
	p = (int *)_mm_malloc(sizeof(int)*C*tds, 32);
*/

	FILE   *fp;
	int i = 0;
	
	if ( argc > 2 ) {
		tds = atoi(argv[1]);
		fp = fopen(argv[2], "r"); 
		if ( fp == NULL) {
			 printf("[ERROR] : Failed to read file named '%s'.\n", argv[2]);
			 exit(1);
		}
	} else {
		printf("USAGE : %s [num threads] [filename].\n", argv[0]);
		exit(1);
	}

	fscanf(fp, "%d %d", &N, &C);
	printf("The number of objects is %d, and the capacity is %d.\n", N, C);

	C = C%32==0?C:((C/32)+1)*32;
	fprintf(stderr,"C padded: %d\n", C);

	w = (int *)_mm_malloc(sizeof(int)*N, 32);
	p = (int *)_mm_malloc(sizeof(int)*N, 32);

	if ( w == NULL || p == NULL ) {
		printf("[ERROR] : Failed to allocate memory for weights/profits.\n");
		exit(1);
	}

	for ( i=0 ; i < N ; i++ ) {
		int count = fscanf(fp, "%d %d", &(w[i]), &(p[i]));
		if ( count != 2 ) {
			 printf("[ERROR] : Input file is not well formatted.\n");
			 exit(1);
		}
	}

	fclose(fp);

	w_max = max_of_array(w,N);

	fprintf(stderr,"w_max actual: %d\n", w_max);

	//pad w_max to be a multiple of 32, since we need 32 byte alined arrays
	w_max = w_max%32==0?w_max:((w_max/32)+1)*32;
	fprintf(stderr,"w_max padded: %d\n", w_max);

	cur = (int *)_mm_malloc(sizeof(int)*C, 32);
	pre = (int *)_mm_malloc(sizeof(int)*C, 32);

//	comb = (int *)_mm_malloc(sizeof(int)*w_max*N*(tds+1),32); //TODO multiply by (tds-1)
	comb = (int **)malloc(sizeof(int *)*(tds+1));
	for (i=0; i<= tds; i++) {
		comb[i] = (int *)_mm_malloc(sizeof(int)*w_max*N,32); //TODO multiply by (tds-1)
	}


	c_per_thread = C/tds;
	c_per_first_thread = C-c_per_thread*(tds-1);

	printf("c_per_thread: %d c_per_first_thread: %d \n", c_per_thread, c_per_first_thread);

	memset(comb[0], 0, w_max*N*sizeof(int));
	memset(&pre[0], 0, C*sizeof(int));
	
	initialize_timer();
	start_timer();

	mykernel(NULL);

	stop_timer();


	long count =0;
	for (i=0; i< C; i++)
	{
		count += (long)cur[i] + (long)pre[i];	
	}

	fprintf(stderr, "run1: %ld\n", count);

	double vector_time = elapsed_time();

	reset_timer();

	//memset(&comb[0], 0, w_max*N*sizeof(int));
	memset(&pre[0], 0, C*sizeof(int));

	start_timer();

	mykernel(NULL);

	stop_timer();

	count =0;
	for (i=0; i< C; i++)
	{
		count += (long)cur[i] + (long)pre[i];	
	}

	fprintf(stderr,"run2: %ld\n", count);

	double vector_time_01 = elapsed_time();

	double gops = (double)((double)((double)((double)2)*(double)N*(double)(C)*(double)tds)/vector_time)/((double)1e9);
	double gops01 = (double)((double)((double)((double)2)*(double)N*(double)(C)*(double)tds)/vector_time_01)/((double)1e9);
	double bw = (double)(C+w_max)*(double)4*(double)3*(double)N/vector_time_01/(double)1e9;
	fprintf(stdout, "Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f time01: %.2f s GOPS01: %.2f N: %d, BW: %.2f max_wi: %d %f %f\n", tds, C, vector_time, gops, vector_time_01, gops01, N, bw, w_max, (float)(C*sizeof(int)*2)/(float)1024.0, (float)(N*w_max*sizeof(int)*(tds+1))/1024.0f);

//	memset(&comb[0], 0, w_max*N*sizeof(int));
	memset(&pre[0], 0, C*sizeof(int));

	my_papi_profile(mykernel);

	count =0;
	for (i=0; i< C; i++)
	{
		count += (long)cur[i] + (long)pre[i];	
	}
	fprintf(stderr,"run3: %ld\n", count);

	return 0;
} 

void *mykernel(void *nothing)
{
#pragma omp parallel num_threads(tds)
	{
		int tid = 0;
#ifdef OMP
		tid = omp_get_thread_num();
#endif
		oneThread(tid);
	}
	return NULL;
}

void oneThread(int threadId)
{
	int *cc;
	int *cp;
	int *tmp;
	int *combin;
	int *combout;

	combin = comb[threadId];
	combout = comb[threadId+1];


	if (threadId == 0) {
		cc = &cur[0];
		cp = &pre[0];
//		memset(&cp[0], 0, c_per_first_thread*sizeof(int));
	} else {
		cc = &cur[c_per_first_thread + c_per_thread*(threadId-1)];
		cp = &pre[c_per_first_thread + c_per_thread*(threadId-1)];
//		memset(&cp[0], 0, c_per_thread*sizeof(int));
	}

//	int i;
	int k;
	int itr = 0;
	int wi;

  __m256i pi,b0,b1,b2,b3;
	__m256i c0,c1,c2,c3;

//	p = _mm256_set_epi32(1,2,2,1,3,4,2,7);

	for (k = 0; k < N; k++) 
	{
		pi =	_mm256_set1_epi32(p[k]);
		wi =	w[k];

		for (itr = 0; itr<w_max; itr+=32)
		{
			b0 = _mm256_load_si256((__m256i*)&combin[k*w_max + itr]);
			b1 = _mm256_load_si256((__m256i*)&combin[k*w_max + itr+8]);
			b2 = _mm256_load_si256((__m256i*)&combin[k*w_max + itr+16]);
			b3 = _mm256_load_si256((__m256i*)&combin[k*w_max + itr+24]);
			c0 = _mm256_load_si256((__m256i*)&cp[itr]);
			c1 = _mm256_load_si256((__m256i*)&cp[itr+8]);	
			c2 = _mm256_load_si256((__m256i*)&cp[itr+16]);	
			c3 = _mm256_load_si256((__m256i*)&cp[itr+24]);	

			c0 = _mm256_max_epi32(_mm256_add_epi32(b0,pi), c0);
			c1 = _mm256_max_epi32(_mm256_add_epi32(b1,pi), c1);
			c2 = _mm256_max_epi32(_mm256_add_epi32(b2,pi), c2);
			c3 = _mm256_max_epi32(_mm256_add_epi32(b3,pi), c3);

			_mm256_store_si256((__m256i*)&cc[itr], c0);
			_mm256_store_si256((__m256i*)&cc[itr+8], c1);	
			_mm256_store_si256((__m256i*)&cc[itr+16], c2);	
			_mm256_store_si256((__m256i*)&cc[itr+24], c3);	
		}

		for (itr = w_max; itr<C-w_max; itr+=32)
		{
			b0 = _mm256_load_si256((__m256i*)&cp[itr-wi]);
			b1 = _mm256_load_si256((__m256i*)&cp[itr-wi+8]);	
			b2 = _mm256_load_si256((__m256i*)&cp[itr-wi+16]);	
			b3 = _mm256_load_si256((__m256i*)&cp[itr-wi+24]);	
			c0 = _mm256_load_si256((__m256i*)&cp[itr]);
			c1 = _mm256_load_si256((__m256i*)&cp[itr+8]);	
			c2 = _mm256_load_si256((__m256i*)&cp[itr+16]);	
			c3 = _mm256_load_si256((__m256i*)&cp[itr+24]);	

			c0 = _mm256_max_epi32(_mm256_add_epi32(b0,pi), c0);
			c1 = _mm256_max_epi32(_mm256_add_epi32(b1,pi), c1);
			c2 = _mm256_max_epi32(_mm256_add_epi32(b2,pi), c2);
			c3 = _mm256_max_epi32(_mm256_add_epi32(b3,pi), c3);

			_mm256_store_si256((__m256i*)&cc[itr], c0);
			_mm256_store_si256((__m256i*)&cc[itr+8], c1);	
			_mm256_store_si256((__m256i*)&cc[itr+16], c2);	
			_mm256_store_si256((__m256i*)&cc[itr+24], c3);	
		}	

		for (itr = C-w_max; itr<C; itr+=32)
		{
			b0 = _mm256_load_si256((__m256i*)&cp[itr-wi]);
			b1 = _mm256_load_si256((__m256i*)&cp[itr-wi+8]);	
			b2 = _mm256_load_si256((__m256i*)&cp[itr-wi+16]);	
			b3 = _mm256_load_si256((__m256i*)&cp[itr-wi+24]);	
			c0 = _mm256_load_si256((__m256i*)&cp[itr]);
			c1 = _mm256_load_si256((__m256i*)&cp[itr+8]);	
			c2 = _mm256_load_si256((__m256i*)&cp[itr+16]);	
			c3 = _mm256_load_si256((__m256i*)&cp[itr+24]);	

			c0 = _mm256_max_epi32(_mm256_add_epi32(b0,pi), c0);
			c1 = _mm256_max_epi32(_mm256_add_epi32(b1,pi), c1);
			c2 = _mm256_max_epi32(_mm256_add_epi32(b2,pi), c2);
			c3 = _mm256_max_epi32(_mm256_add_epi32(b3,pi), c3);

			_mm256_store_si256((__m256i*)&cc[itr], c0);
			_mm256_store_si256((__m256i*)&cc[itr+8], c1);	
			_mm256_store_si256((__m256i*)&cc[itr+16], c2);	
			_mm256_store_si256((__m256i*)&cc[itr+24], c3);	
			_mm256_store_si256((__m256i*)&combout[k*w_max + itr], c0);
			_mm256_store_si256((__m256i*)&combout[k*w_max + itr+8], c1);
			_mm256_store_si256((__m256i*)&combout[k*w_max + itr+16], c2);
			_mm256_store_si256((__m256i*)&combout[k*w_max + itr+24], c3);
		}

		tmp = cc;
		cc = cp;
		cp = tmp;	
	}
}

int max_of_array(int *a, int length) {
	int imax = 0;
	int i;

	for (i=0; i<length; i++) {
		imax = MAX(imax, a[i]); 
	}

	return imax;
}
