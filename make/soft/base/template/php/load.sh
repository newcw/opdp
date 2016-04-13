#!/bin/bash

# desc: php启停脚本，必须使用此脚本启停
# auth: zhaixinrui
# date: 2015-02-02 


#get Current Dir
this_dir=$PWD
dirname $0|grep "^/" >/dev/null
if [ $? -eq 0 ];then
        this_dir=$(dirname $0)
else
        dirname $0|grep "^\." >/dev/null
        retval=$?
        if [ $retval -eq 0 ];then
                this_dir=$(dirname $0|sed "s#^.#$this_dir#")
        else
                this_dir=$(dirname $0|sed "s#^#$this_dir/#")
        fi
fi

cd $this_dir || exit

start() {
    sbin/php-fpm
    if [ 0 -eq $? ];then
        echo "start php-fpm Done!"
    else
        echo "start php-fpm Fail!"
    fi
}

stop() {
    pid_file=$this_dir/../logs/php/php-fpm.pid
    if [ ! -f $pid_file ];then
        echo "stop php-fpm Fail!, pid file not exsit"
        return
    fi

    pid=$(cat $pid_file)
    if [ -z $pid ];then
        echo "stop php-fpm Fail!, pid not exsit"
        return
    fi

    for i in `ps -ef|grep php-fpm|grep $pid|awk '{print $2}'`;do
        kill -9 $i
    done

    if [ 0 -eq $? ];then
        echo "stop php-fpm Done!"
    else
        echo "stop php-fpm Fail!"
    fi
}

case "X$1" in
	Xstart)
                stop
		start
		;;
	Xstop)
		stop
		;;
	*)
		echo "Usage: $0 {start|stop}"
		;;
esac

cd - >/dev/null
