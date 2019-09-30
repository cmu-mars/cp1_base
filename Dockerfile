FROM cmu-mars/gazebo

RUN sudo apt-get update && \
    sudo apt-get install -y libignition-math2-dev

ADD cp1_base src/cp1_base

RUN . /opt/ros/kinetic/setup.sh && \
    sudo chown -R $(whoami):$(whoami) .

# Clonning plugins and packages
RUN git clone https://github.com/cmu-mars/brass_gazebo_battery.git src/brass_gazebo_battery
RUN git clone https://github.com/cmu-mars/brass_gazebo_config_manager.git src/brass_gazebo_config_manager
RUN git clone https://github.com/cmu-mars/model-learner.git src/model_learner
RUN git clone https://github.com/cmu-mars/cp1_controllers.git src/cp1_controllers

RUN sudo apt-get install -y python-pip
RUN sudo apt-get install -y python3-pip

RUN sudo pip3 install catkin_pkg rospkg numpy psutil defusedxml flask-script keras tensorflow

# installing packages
RUN python3 -m pip install --upgrade src/model_learner
RUN python3 -m pip install --upgrade src/cp1_controllers

RUN . /opt/ros/kinetic/setup.sh && \
    catkin_make

CMD ["/bin/bash"]
