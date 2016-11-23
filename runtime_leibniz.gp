reset
set ylabel 'Time(sec)'
set xlabel 'N'
set style fill solid
set title 'wall clock time - leibniz'
set term png enhanced font 'Verdana,10'
set output 'runtime_leibniz.png'
set logscale x 2
set datafile separator ","

plot [64:35000][0:] 'result_clock_gettime_leibniz.csv' using 1:2 smooth csplines lw 2 title 'leibniz', \
'' using 1:3 smooth csplines lw 2 title 'leibniz_openmp_2', \
'' using 1:4 smooth csplines lw 2 title 'leibniz_openmp_4', \
'' using 1:5 smooth csplines lw 2 title 'leibniz_avx', \
'' using 1:6 smooth csplines lw 2 title 'leibniz_avx_unroll', \

