#### op deploy

#####安装条件

    centos
    
    yum install -y gcc gcc-c++ libatomic_ops-devel.x86_64 libxml2.x86_64 libxml2-devel openssl-devel.x86_64 libcurl-devel.x86_64 libjpeg-devel libpng-devel freetype-devel libmcrypt-devel.x86_64 libatomic_ops-devel.x86_64


#####安装

    git clone https://github.com/newcw/opd.git
    cd opd

    

######安装php + nginx
    
    ./install.sh project-name server-port

