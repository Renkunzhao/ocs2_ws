cd $WORKSPACE/ocs2_ws/src

git clone --recurse-submodules --depth=1 https://github.com/Renkunzhao/legged_wbc.git
git clone --recurse-submodules --depth=1 https://github.com/Renkunzhao/legged_control.git

catkin build legged_controllers legged_unitree_description legged_gazebo --cmake-args -DCATKIN_ENABLE_TESTING=ON

catkin run_tests legged_wbc

jq -s 'add' $(find ../build/ -name compile_commands.json) > ../build/compile_commands.json

export ROBOT_TYPE=go1
