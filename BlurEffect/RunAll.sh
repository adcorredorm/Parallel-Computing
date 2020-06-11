#! /bin/bash

kernel_size=3
while (( $kernel_size <= 15 ))
do
	./Run.sh $kernel_size
	kernel_size=$(( kernel_size+2 ))	
done