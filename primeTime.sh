#!/bin/sh
#is the time since unix epoch a prime number?
while true; 
    do echo `date +%s`; 
    myProjects/primetest.pl `date +%s`; 
    sleep 1; 
    clear; 
done
