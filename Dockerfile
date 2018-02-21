FROM cmu-mars/gazebo

ADD cp1_base src/cp1_base

RUN source /opt/ros/kinetic/setup.sh && \
    sudo chown -R $(whoami):$(whoami) .

RUN git clone https://github.com/cmu-mars/brass_gazebo_battery.git \
    src/brass_gazebo_battery && \
    cd src/brass_gazebo_battery && \
    git checkout master

RUN source /opt/ros/kinetic/setup.sh && \
    catkin_make

CMD ["/bin/bash"]

