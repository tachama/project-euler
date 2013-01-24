#!/bin/sh
# -*- coding: utf-8 -*-
#
# prcheck.sh
#   各プログラムの静的チェックを行う。
#
#   対応言語 : Python(*.py), Haskell(*.hs)
#

PEP8=/usr/bin/pep8
PEP8_OPTS="--ignore=E111,E231,E302"
PYCHECKER=/usr/bin/pychecker
PYCHECKER_OPTS=
PYLINT=/usr/bin/pylint
PYLINT_OPTS=

HLINT=/usr/bin/hlint
HLINT_OPTS=

SPLINT=/usr/bin/splint
SPLINT_OPTS=


# Pythonプログラムの静的チェック
#   pep8, pychecker, pylint
check_python() {
    prg=$1
    echo "***** check" ${prg} "with pep8 *****"
    ${PEP8} ${PEP8_OPTS} ${prg}
    echo "***** check" ${prg} "with pychecker *****"
    ${PYCHECKER} ${PYCHECKER_OPTS} ${prg}
    echo "***** check" ${prg} "with pylint *****"
    ${PYLINT} ${PYLINT_OPTS} ${prg}
}


# Haskellプログラムの静的チェック
#   hlint
check_haskell() {
    prg=$1
    echo "***** check" ${prg} "with hlint *****"
    ${HLINT} ${HLINT_OPTS} ${prg}
}

# Cプログラムの静的チェック
check_c() {
    prg=$1
    echo "***** check" ${prg} "with splint *****"
    ${SPLINT} ${SPLINT_OPTS} ${prg}
}


# プログラム言語をファイル名から決定する。
# (0: Unknown, 1: Python, 2: Haskell, 3: C)
program_type() {
    type=0
    case $1 in
	*.py) type=1 ;;  # Python
	*.hs) type=2 ;;  # Haskell
	*.c)  type=3 ;;  # C
	*)    type=0 ;;  # Unkonwn
    esac
    return ${type}
}


for prg in $*; do
    program_type ${prg}
    case $? in
	1) check_python ${prg} ;;   # Python
	2) check_haskell ${prg} ;;  # Haskell
	3) check_c ${prg} ;;        # C
	*) echo "error: unknown program type ->" ${prg}
    esac
done
