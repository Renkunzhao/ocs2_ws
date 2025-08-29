#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src
cd $PROJECT_DIR/src

# Clone ocs2
git clone --recurse-submodules --depth=1 https://github.com/Renkunzhao/ocs2.git

# Clone pinocchio
# git clone --recurse-submodules --depth=1 https://github.com/leggedrobotics/pinocchio.git
# git clone --recurse-submodules --depth=1 -b v3.7.0 https://github.com/stack-of-tasks/pinocchio.git 

# Clone hpp-fcl
git clone --recurse-submodules --depth=1 https://github.com/leggedrobotics/hpp-fcl.git

# Clone ocs2_robotic_assets
git clone --depth=1 https://github.com/leggedrobotics/ocs2_robotic_assets.git

# Clone grid map
git clone --depth=1 https://github.com/ANYbotics/grid_map.git

# Clone elevation mapping cupy
git clone --depth=1 https://github.com/Renkunzhao/elevation_mapping_cupy.git

# Clone raisim
git clone --depth=10 https://github.com/raisimTech/raisimLib.git
cd raisimLib
git checkout d00f948233f73f79a36ad912d7d79a47c0f9edd8

cd $PROJECT_DIR
catkin init
catkin config --extend /opt/ros/noetic
# catkin config --install
# catkin config --install-space $PROJECT_DIR/install/ocs2/
# catkin config --cmake-args -DCMAKE_BUILD_TYPE=Debug
catkin config -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5 --cmake-args -Wno-dev
catkin build raisim 
catkin build ocs2_legged_robot_raisim convex_plane_decomposition_ros

jq -s 'add' $(find build/ -name compile_commands.json) > build/compile_commands.json