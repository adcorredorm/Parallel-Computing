#! /bin/bash

make clean
make

KERNEL=3

echo "Experiments with a kernel of" $KERNEL >StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

KERNEL=5

echo "Experiments with a kernel of" $KERNEL >>StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

KERNEL=7

echo "Experiments with a kernel of" $KERNEL >>StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

KERNEL=9

echo "Experiments with a kernel of" $KERNEL >>StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

KERNEL=11

echo "Experiments with a kernel of" $KERNEL >>StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

KERNEL=13

echo "Experiments with a kernel of" $KERNEL >>StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt
KERNEL=15

echo "Experiments with a kernel of" $KERNEL >>StatisticsAll.txt
#720P image
echo '---------------------------------------------' >> StatisticsAll.txt
echo '720P Image' >> StatisticsAll.txt
#Blur effect with 2 threads 
./blur-effect 720.png 720Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 4 threads
./blur-effect 720.png 720Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 8 threads
./blur-effect 720.png 720Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 720Result.png

#Blur effect with 16 threads
./blur-effect 720.png 720Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#1080P image
echo '1080P Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 1080.png 1080Result.png $KERNEL 2 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 4 threads
./blur-effect 1080.png 1080Result.png $KERNEL 4 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 8 threads
./blur-effect 1080.png 1080Result.png $KERNEL 8 >> StatisticsAll.txt
rm -f 1080Result.png

#Blur effect with 16 threads
./blur-effect 1080.png 1080Result.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt

#4k image
echo '4k Image' >> StatisticsAll.txt

#Blur effect with 2 threads 
./blur-effect 4k.png 4kResult.png $KERNEL 2 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 4 threads
./blur-effect 4k.png 4kResult.png $KERNEL 4 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 8 threads
./blur-effect 4k.png 4kResult.png $KERNEL 8 >> StatisticsAll.txt
rm -f 4kResult.png

#Blur effect with 16 threads
./blur-effect 4k.png 4kResult.png $KERNEL 16 >> StatisticsAll.txt
echo '---------------------------------------------' >> StatisticsAll.txt
