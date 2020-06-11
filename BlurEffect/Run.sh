#! /bin/bash

make clean
make

KERNEL = $1

echo "Experiments with a kernel of" $KERNEL >Statistics.txt
#720P image
echo '---------------------------------------------' >> Statistics.txt
echo '720P Image' >> Statistics.txt

#Blur effect with 1 threads 
mpirun -np 1 --hostfile mpi_hosts ./blur-effect 720.png 720Result.png $KERNEL 1 >> Statistics.txt
rm -f 720Result.png

#Blur effect with 2 threads 
mpirun -np 2 --hostfile mpi_hosts ./blur-effect 720.png 720Result.png $KERNEL 2 >> Statistics.txt
rm -f 720Result.png

#Blur effect with 4 threads
mpirun -np 4 --hostfile mpi_hosts ./blur-effect 720.png 720Result.png $KERNEL 4 >> Statistics.txt
rm -f 720Result.png

#Blur effect with 8 threads
mpirun -np 8 --hostfile mpi_hosts ./blur-effect 720.png 720Result.png $KERNEL 8 >> Statistics.txt
rm -f 720Result.png

#Blur effect with 16 threads
#./blur-effect 720.png 720Result.png $KERNEL 16 >> Statistics.txt
echo '---------------------------------------------' >> Statistics.txt

#1080P image
echo '1080P Image' >> Statistics.txt

#Blur effect with 1 threads 
mpirun -np 1 --hostfile mpi_hosts ./blur-effect 1080.png 1080Result.png $KERNEL 1 >> Statistics.txt
rm -f 1080Result.png

#Blur effect with 2 threads 
mpirun -np 2 --hostfile mpi_hosts ./blur-effect 1080.png 1080Result.png $KERNEL 2 >> Statistics.txt
rm -f 1080Result.png

#Blur effect with 4 threads
mpirun -np 4 --hostfile mpi_hosts ./blur-effect 1080.png 1080Result.png $KERNEL 4 >> Statistics.txt
rm -f 1080Result.png

#Blur effect with 8 threads
mpirun -np 8 --hostfile mpi_hosts ./blur-effect 1080.png 1080Result.png $KERNEL 8 >> Statistics.txt
rm -f 1080Result.png

#Blur effect with 16 threads
#./blur-effect 1080.png 1080Result.png $KERNEL 16 >> Statistics.txt
echo '---------------------------------------------' >> Statistics.txt

#4k image
echo '4k Image' >> Statistics.txt

#Blur effect with 1 threads 
mpirun -np 1 --hostfile mpi_hosts ./blur-effect 4k.png 4kResult.png $KERNEL 1 >> Statistics.txt
rm -f 4kResult.png

#Blur effect with 2 threads 
mpirun -np 2 --hostfile mpi_hosts ./blur-effect 4k.png 4kResult.png $KERNEL 2 >> Statistics.txt
rm -f 4kResult.png

#Blur effect with 4 threads
mpirun -np 4 --hostfile mpi_hosts ./blur-effect 4k.png 4kResult.png $KERNEL 4 >> Statistics.txt
rm -f 4kResult.png

#Blur effect with 8 threads
mpirun -np 8 --hostfile mpi_hosts ./blur-effect 4k.png 4kResult.png $KERNEL 8 >> Statistics.txt
rm -f 4kResult.png

#Blur effect with 16 threads
#./blur-effect 4k.png 4kResult.png $KERNEL 16 >> Statistics.txt
echo '---------------------------------------------' >> Statistics.txt
