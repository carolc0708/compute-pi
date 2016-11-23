CC = gcc
CFLAGS = -O0 -std=gnu99 -Wall -fopenmp -mavx
EXECUTABLE = \
	time_test_baseline time_test_openmp_2 time_test_openmp_4 \
	time_test_avx time_test_avxunroll time_test_leibniz\
	time_test_leibniz_openmp_2 time_test_leibniz_openmp_4\
	time_test_leibniz_avx time_test_leibniz_avx_unroll\
	time_test_euler\
	benchmark_clock_gettime

default: computepi.o
	$(CC) $(CFLAGS) computepi.o time_test.c -DBASELINE -o time_test_baseline -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DOPENMP_2 -o time_test_openmp_2 -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DOPENMP_4 -o time_test_openmp_4 -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DAVX -o time_test_avx -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DAVXUNROLL -o time_test_avxunroll -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ -o time_test_leibniz -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ_OPENMP_2 -o time_test_leibniz_openmp_2 -lm
	 $(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ_OPENMP_4 -o time_test_leibniz_openmp_4 -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ_AVX -o time_test_leibniz_avx -lm
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ_AVX_UNROLL -o time_test_leibniz_avx_unroll -lm
	 $(CC) $(CFLAGS) computepi.o time_test.c -DEULER -o time_test_euler -lm
	$(CC) $(CFLAGS) computepi.o benchmark_clock_gettime.c -o benchmark_clock_gettime -lm
	$(CC) $(CFLAGS) computepi.o benchmark_clock_gettime_leibniz.c -o benchmark_clock_gettime_leibniz -lm


.PHONY: clean default

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@ 

check: default
	time ./time_test_baseline
	time ./time_test_openmp_2
	time ./time_test_openmp_4
	time ./time_test_avx
	time ./time_test_avxunroll
	time ./time_test_leibniz
	time ./time_test_leibniz_openmp_2
	time ./time_test_leibniz_openmp_4
	time ./time_test_leibniz_avx
	time ./time_test_leibniz_avx_unroll
	time ./time_test_euler

gencsv: default
	for i in `seq 100 5000 25000`; do \
		printf "%d," $$i;\
		./benchmark_clock_gettime $$i; \
	done > result_clock_gettime.csv\
	
	for i in `seq 100 5000 25000`; do \
                printf "%d," $$i;\
                ./benchmark_clock_gettime_leibniz $$i; \
        done > result_clock_gettime_leibniz.csv

plot: gencsv
	gnuplot	runtime.gp
	gnuplot runtime_leibniz.gp

clean:
	rm -f $(EXECUTABLE) *.o *.s result_clock_gettime.csv result_clock_gettime_leibniz.csv
