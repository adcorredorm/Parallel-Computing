#! /bin/bash

make clean
make

KERNEL=3
IMAGE=4k.png
IMAGERESULT=Result.png
CORES=16

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES > StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT

KERNEL=5

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT

KERNEL=7

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
KERNEL=9

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
KERNEL=11

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
KERNEL=13

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
KERNEL=15

./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
./blur-effect $IMAGE $IMAGERESULT $KERNEL $CORES >> StatisticsAll.txt
rm -f $IMAGERESULT
