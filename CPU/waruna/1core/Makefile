#CC := icc
CC := gcc

EXES := kpdp_2_arrays_thread_pointer kpdp_2_arrays_thread_pointerp papi_sample1 papi_sample my_papi kpdp_2_arrays_thread_pointerp kpdp_2_arrays_thread_pointer kpdp_2_arrays_in_1malloc_thread_pointer kpdp_2_arrays_in_1malloc_thread_pointerp kpdp_2_arrays_global_pointer kpdp_2_arrays_global_pointerp kpdp_2_arrays_in_1malloc_global_pointer kpdp_2_arrays_in_1malloc_global_pointerp kpdp_2_arrays_in_1malloc_thread_mod kpdp_2_arrays_in_1malloc_thread_modp kpdp_2_arrays_in_1malloc_global_mod kpdp_2_arrays_in_1malloc_global_modp

SSEFLAGS := -msse4.2
AVXFLAGS := -mavx
AVX2FLAGS := -mavx2
VECTORFLAGS := $(AVX2FLAGS)
OMPFLAGS := -fopenmp
VEC_REPORT := -ftree-vectorizer-verbose=6
OTHER_FLAGS := -Wall -g
LIBS := -L/s/chopin/e/proj/AlphaZ/waruna/papi/installation/5.4.1/lib -lpapi

%.o: %.c %.h
	$(CC) -O3 -c $< -o $@ $(OTHER_FLAGS)

%.s: %.c
	$(CC) -O3 -S $< > $@ $(VECTORFLAGS)
	#$(CC) -O3 -S $< > $@ $(VECTORFLAGS) $(OMPFLAGS)
	#$(CC) -O3 -S -masm=intel $< > $@ $(VECTORFLAGS)
	#make clean
	#make cpu_max_plus_debug
	#objdump -S -l $<_debug > $@
	#make clean

kpdp_2_arrays_thread_pointer: kpdp_2_arrays_thread_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) timer.o my_papi.o $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_thread_pointerp: kpdp_2_arrays_thread_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OMPFLAGS) timer.o my_papi.o -DOMP $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_thread_pointer: kpdp_2_arrays_in_1malloc_thread_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) timer.o my_papi.o $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_thread_pointerp: kpdp_2_arrays_in_1malloc_thread_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OMPFLAGS) timer.o my_papi.o -DOMP $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_global_pointer: kpdp_2_arrays_global_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) timer.o my_papi.o $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_global_pointerp: kpdp_2_arrays_global_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OMPFLAGS) timer.o my_papi.o -DOMP $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_global_pointer: kpdp_2_arrays_in_1malloc_global_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) timer.o my_papi.o $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_global_pointerp: kpdp_2_arrays_in_1malloc_global_pointer.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OMPFLAGS) timer.o my_papi.o -DOMP $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_thread_mod: kpdp_2_arrays_in_1malloc_thread_mod.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) timer.o my_papi.o $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_thread_modp: kpdp_2_arrays_in_1malloc_thread_mod.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OMPFLAGS) timer.o my_papi.o -DOMP $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_global_mod: kpdp_2_arrays_in_1malloc_global_mod.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) timer.o my_papi.o $(OTHER_FLAGS) $(LIBS)

kpdp_2_arrays_in_1malloc_global_modp: kpdp_2_arrays_in_1malloc_global_mod.c timer.o my_papi.o
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OMPFLAGS) timer.o my_papi.o -DOMP $(OTHER_FLAGS) $(LIBS)

papi_sample:	papi_sample.c
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OTHER_FLAGS) $(LIBS)

papi_sample1:	papi_sample1.c
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OTHER_FLAGS) $(LIBS)

my_papi:	my_papi.c my_papi.h
	$(CC) -O3 -o $@ $< $(VECTORFLAGS) $(OTHER_FLAGS) $(LIBS)


clean:
	rm -f *.o $(EXES)
