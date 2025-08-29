This repo includes scripts to ease the configuratio of [OCS2](https://github.com/Renkunzhao/ocs2) and [legged_contrl](https://github.com/Renkunzhao/legged_control)

# Usage
```bash
git clone https://github.com/Renkunzhao/ocs2_ws.git
cd ocs2_ws/scripts
docker build -t ocs2-ws .
./start-ws.sh 
```

- this will build & install dependencies automatically, and open a docker container, the following command are all running in the container
```bash
cd /root/code/ocs2_ws
./scripts/ocs2-config.sh
source devel/setup.bash 
roslaunch ocs2_legged_robot_ros legged_robot_ddp.launch
```

```bash
cd /root/code/ocs2_ws
./scripts/legged_control-config.sh
source devel/setup.bash 
roslaunch legged_unitree_description empty_world.launch

# in a different window
roslaunch legged_controllers load_controller.launch cheater:=false

# in a different window
rqt # open Controller Manager & Robot Steering

# in a different window
rostopic pub /jump std_msgs/Bool "data: true" --once
```
