FROM ubuntu:latest

RUN apt-get update -yq \
    && apt-get install -yqq python3 \
                            python3-pip \
                            python3-pyqt5 \
                            python3-setuptools \
                            curl \
# Install matplotlib
    && /usr/bin/python3 -m pip install matplotlib \
# Set Qt as the default backend
    && echo "backend: qt5agg" >> matplotlibrc \
# Download an example animation and run it
    && curl https://matplotlib.org/_downloads/strip_chart.py -o strip_chart.py

CMD /usr/bin/python3 /strip_chart.py
