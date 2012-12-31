#!/bin/sh
#  compile and execute c program.

# compiler and comple option
cc=gcc
copts="-Wall -Werror"

# a.out file name
aout=a.out
core=core

compile_execute() {
    ${cc} ${copts} $1
    if [ $? -eq 0 ]; then
        ./${aout}
        rm -f ${aout} ${core}
    fi
}

for prg in $*; do
    compile_execute ${prg}
done
