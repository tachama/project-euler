#!/bin/sh
# -*- coding: utf-8 -*-
#
# check.sh
#   プログラムの作成漏れをチェックする。
#
# [使い方]
#   ./check.sh
#

# 対応しているプログラムのサフィックスリスト
# (python->py, haskell->hs, commonlisp->lisp)
#suffixes="py hs lisp c"
suffixes="py hs c"  # XXX: common-lispは今は除外する

# 問題番号のプログラムが存在するかを確認する
exist_program() {
    token=`printf pr%03d $1`
    # 標準エラー出力は/dev/nullへリダイレクトする
    num=`ls -l ${token}.* 2> /dev/null | wc -l`
    return ${num}
}

# 問題で不足しているプログラムがあれば出力する
check_program() {
    token=`printf pr%03d $1`
    for suffix in ${suffixes}; do
        if [ ! -e ${token}.${suffix} ]; then
            case "${suffix}" in
                "py" ) lang="Python" ;;
                "hs" ) lang="Haskell" ;;
                "lisp" ) lang="CommonLisp" ;;
                "c"  ) lang="C" ;;
                * ) lang="UNKNOWN" ;;
            esac
            echo "Problem $1: ${lang} version is not exist!; ${token}.${suffix}"
        fi
    done
}

prno=1
exist_program ${prno}
while [ $? -ne 0 ]; do
    check_program ${prno}
    prno=`expr ${prno} + 1`
    exist_program ${prno}
done
