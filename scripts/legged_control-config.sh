catkin build legged_controllers legged_unitree_description legged_gazebo

jq -s 'add' $(find ../build/ -name compile_commands.json) > ../build/compile_commands.json

export ROBOT_TYPE=go1
