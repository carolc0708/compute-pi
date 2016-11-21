reset
set ylabel 'Time(sec)'
set xlabel 'N'
set style fill solid
set title 'wall clock time - using clock_gettime()'
set term png enhanced font 'Verdana,10'
set output 'runtime.png'
set logscale x 2
set datafile separator ","

plot [64:35000][0:] 'result_clock_gettime.csv' using 1:2 smooth csplines lw 2 title 'baseline', \
'' using 1:3 smooth csplines lw 2 title 'omp_2', \
'' using 1:4 smooth csplines lw 2 title 'omp_4', \
'' using 1:5 smooth csplines lw 2 title 'avx', \
'' using 1:6 smooth csplines lw 2 title 'avxunroll', \
'' using 1:7 smooth csplines lw 2 title 'leibniz', \
'' using 1:8 smooth csplines lw 2 title 'euler'

