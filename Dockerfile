FROM cmumars/gazebo
RUN sudo apt-key del 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654



RUN sudo apt-get update && \
    sudo apt-get install -y libignition-math2-dev

ADD cp1_base src/cp1_base

RUN . /opt/ros/kinetic/setup.sh && \
    sudo chown -R $(whoami):$(whoami) .

RUN sudo apt-get install -y python-pip
RUN sudo apt-get install -y python3-pip
RUN sudo apt-get install -y python3-matplotlib
RUN sudo pip3 install catkin_pkg rospkg numpy psutil defusedxml flask-script GPy GPyOpt 

# Clonning plugins and packages
ADD https://api.github.com/repos/cmu-mars/brass_gazebo_battery/git/refs/heads/ bgb_version.json
RUN git clone https://github.com/cmu-mars/brass_gazebo_battery.git src/brass_gazebo_battery
ADD https://api.github.com/repos/cmu-mars/brass_gazebo_config_manager/git/refs/heads/ bgcm_version.json
RUN git clone https://github.com/cmu-mars/brass_gazebo_config_manager.git src/brass_gazebo_config_manager
ADD https://api.github.com/repos/cmu-mars/model-learner/git/refs/heads/ ml_version.json
RUN git clone https://github.com/cmu-mars/model-learner.git src/model_learner
ADD https://api.github.com/repos/cmu-mars/cp1_controllers/git/refs/heads/ ctrl_version.json
RUN git clone https://github.com/cmu-mars/cp1_controllers.git src/cp1_controllers

# installing packages
RUN pip3 install --upgrade src/model_learner
RUN pip3 install --upgrade src/cp1_controllers

RUN pip3 install --upgrade -r src/model_learner/requirements.txt
RUN pip3 install --upgrade -r src/cp1_controllers/requirements.txt

RUN . /opt/ros/kinetic/setup.sh && \
    catkin_make

CMD ["/bin/bash"]
