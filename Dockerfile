FROM cmu-mars/gazebo

RUN sudo apt-get update && \
    sudo apt-get install -y ros-kinetic-mrpt-navigation libignition-math2-dev

ADD cp1_base src/cp1_base

RUN sudo mkdir ~/cp1/

RUN . /opt/ros/kinetic/setup.sh && \
    sudo chown -R $(whoami):$(whoami) .

# Plugins
RUN git clone https://github.com/cmu-mars/brass_gazebo_battery.git src/brass_gazebo_battery
RUN git clone https://github.com/cmu-mars/brass_gazebo_config_manager.git src/brass_gazebo_config_manager

RUN . /opt/ros/kinetic/setup.sh && \
    catkin_make

CMD ["/bin/bash"]
