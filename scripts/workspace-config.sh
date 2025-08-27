#!/bin/bash

############################################
# 打开 ssh 服务
service ssh start
echo "export DISPLAY=:0" >> /root/.bashrc

############################################
# 将/usr/local/lib加入默认路径
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/local-lib.conf
echo "sudo ldconfig" >> /root/.bashrc

############################################
# 设置 WORKSPACE
# 如果 $WORKSPACE 变量未定义或为空，则将其设置为 /root/code
: ${WORKSPACE:=/root/code/third_party}
echo "set WORKSPACE:$WORKSPACE"
mkdir -p $WORKSPACE
echo "export WORKSPACE=$WORKSPACE" >> /root/.bashrc
cd $WORKSPACE

############################################
# 安装 cmake (osqp 依赖)
cd $WORKSPACE
git clone --depth=1 https://gitlab.kitware.com/cmake/cmake.git
cd cmake
mkdir build
cd build
cmake ..
make -j$(nproc) && sudo make install

############################################
# 安装 osqp
cd $WORKSPACE
echo "Executing actions for osqp..."
echo "Downloading osqp..."
git clone --depth=1 https://github.com/osqp/osqp.git
cd osqp
mkdir build
cd build
bash -c "cmake -DOSQP_USE_LONG=OFF .."
make -j$(nproc) && sudo make install

############################################
# 安装 qpOASES
cd $WORKSPACE
echo "Executing actions for qpOASES..."
echo "Downloading qpOASES..."
git clone --recurse-submodules --depth=1 https://github.com/coin-or/qpOASES.git
cd qpOASES
mkdir build
cd build
bash -c "cmake -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE .."         # set -fPIC option; otherwise qpOASES can't be linked by shared lib
make -j$(nproc) && sudo make install

cd $WORKSPACE/../
exec bash
