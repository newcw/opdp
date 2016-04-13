#!/bin/bash

# desc: nginx启停脚本，必须使用此脚本启停
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
    sbin/nginx
    if [ 0 -eq $? ];then
        echo "start nginx Done!"
    else
        echo "start nginx Fail!"
    fi
}

stop() {
    sbin/nginx -s stop
    if [ 0 -eq $? ];then
        echo "stop nginx Done!"
    else
        echo "stop nginx Fail!"
    fi
}

reload() {
    sbin/nginx -s reload
    if [ 0 -eq $? ];then
        echo "reload nginx Done!"
    else
        echo "reload nginx Fail!"
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
	Xreload)
		reload
		;;
	*)
		echo "Usage: $0 {start|stop|reload}"
		;;
esac

cd - >/dev/null
