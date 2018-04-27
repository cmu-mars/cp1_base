FROM cmu-mars/gazebo

RUN sudo apt-get update && \
    sudo apt-get install -y libignition-math2-dev

ADD cp1_base src/cp1_base

RUN sudo mkdir ~/cp1/

RUN . /opt/ros/kinetic/setup.sh && \
    sudo chown -R $(whoami):$(whoami) .

# Plugins
RUN git clone https://github.com/cmu-mars/brass_gazebo_battery.git src/brass_gazebo_battery
RUN git clone https://github.com/cmu-mars/brass_gazebo_config_manager.git src/brass_gazebo_config_manager
RUN git clone https://github.com/cmu-mars/model-learner.git src/model_learner

RUN sudo apt-get install -y python-pip

RUN python -m pip install --upgrade src/model_learner

RUN . /opt/ros/kinetic/setup.sh && \
    catkin_make

CMD ["/bin/bash"]
