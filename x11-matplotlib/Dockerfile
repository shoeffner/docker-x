FROM ubuntu:latest

# Install python, pyqt5, curl
RUN apt-get update -yq && apt-get install -yqq python3 python3-pyqt5 python3-setuptools curl
# Install pip and matplotlib
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN /usr/bin/python3 get-pip.py
RUN /usr/bin/python3 -m pip install matplotlib

# Set Qt as the default backend
RUN echo "backend: qt5agg" >> matplotlibrc

# Download an example animation and run it
RUN curl https://matplotlib.org/_downloads/strip_chart.py -o strip_chart.py
CMD /usr/bin/python3 /strip_chart.py
