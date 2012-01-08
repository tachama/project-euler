#!/bin/sh
#
#  test all language program result same answer

result_ok=0
result_ng=0
result_skip=0


test()
{
    problem=$1
    value=
    done=0

    # execute python version.
    #  skip if python version is not exist. - XXX
    if [ -e ${problem}.py ]; then
        value=`python ${problem}.py`
    else
        result_skip=`expr ${result_skip} + 1`
        return
    fi

    # execute haskell version
    if [ -e ${problem}.hs ]; then
        val=`runghc ${problem}.hs`
        if [ ${value} != ${val} ]; then
            result_ng=`expr ${result_ng} + 1`
            return
        fi
        done=`expr ${done} + 1`
    fi

    # execute common-lisp version
    if [ -e ${problem}.lisp ]; then
        val=`sbcl ${problem}.lisp`
        if [ ${value} != ${val} ]; then
            result_ng=`expr ${result_ng} + 1`
            return
        fi
        done=`expr ${done} + 1`
    fi

    # check ok or skip
    if [ ${done} -gt 0 ]; then
        result_ok=`expr ${result_ok} + 1`
    else
        result_skip=`expr ${result_skip} + 1`
    fi
}

tests()
{
    while [ "$1" != "" ]; do
        test $1
        shift 1
    done
}

print_result()
{
    echo "Num of TESTS = " `expr ${result_ok} + ${result_ng} + ${result_skip}`
    echo "  : Success -> ${result_ok}"
    echo "  : Fail    -> ${result_ng}"
    echo "  : Skip    -> ${result_skip}"
}

main()
{
    if [ "$#" -ne 0 ]; then
        # we test command argument
        target="$@"
    else
        # we test all problem, found from python - XXX
        target=`ls *.py | sed -e "s/\.py//"`
    fi

    tests ${target}

    print_result
}

main "$@"
