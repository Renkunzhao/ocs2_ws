# 基于ros-noetic的Ubuntu 20.04镜像
FROM osrf/ros:noetic-desktop-full

# 关闭交互
ENV DEBIAN_FRONTEND=noninteractive

    # 换源
# RUN sed -i "s@http://.*archive.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list && \
#     sed -i "s@http://.*security.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list

RUN apt update && \
    # 管理软件源、GPG秘钥、APT开启https下载、CA证书
    apt install -y lsb-release software-properties-common gnupg2 apt-transport-https ca-certificates python3-pip && \
    # 常用网络包
    apt install -y iputils-ping iproute2 wget curl && \
    # 构建工具、代码管理、数学库、空间管理
    apt install -y build-essential cmake git vim gdb libboost-all-dev libeigen3-dev ncdu

    # 安装工程依赖
    # rviz/ros 可视化依赖
RUN apt install -y gnome-terminal dbus-x11 && \
    # 安装 gridmap 依赖
    apt install -y ros-noetic-costmap-2d && \
    # 安装 OCS2 依赖
    apt install -y libglpk-dev libgmp-dev libmpfr-dev ros-noetic-pybind11-catkin python3-catkin-tools && \
    apt install -y ros-noetic-rqt-multiplot ros-noetic-octomap-msgs ros-noetic-pinocchio && \
    # 安装 mpc-net 依赖
    apt install -y rsync python3-venv && \
    # 安装 legged_control 依赖
    apt install -y ros-noetic-rqt-controller-manager

    # 配置 ssh 服务
RUN apt install -y openssh-server && \
    echo "root:'" | chpasswd && \
    # 允许 root 通过 SSH 访问
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

    # 工具
    # 合并compile_commands.json文件
RUN apt install -y jq && \
    # 格式化代码
    apt install -y clang-format

# 复制入口脚本到容器
COPY workspace-config.sh /workspace-config.sh
# 使用 entrypoint.sh 作为容器的入口点
ENTRYPOINT ["/workspace-config.sh"]

