# X Server inside Docker container on macOS


## tl;dr

```
open -a XQuartz  # macOS X clone
IP=$(ipconfig getifaddr en0)
xhost + ${IP}  # add local address to allowed hosts for X
docker run -e DISPLAY=${IP}:0 -v /tmp/.X11-unix:/tmp/.X11-unix --name X11-enabled-container ${IMAGE}
```


## Slightly longer read

1. Install Docker, XQuartz (`brew bundle`, or use brew cask)
2. Maybe you need to restart now.
3. Run XQuartz. (`open -a XQuartz`)
4. Add the lan adapter IP to the list of allowed X hosts (`xhost + $(ipconfig getifaddr en0)`).
5. Run the container:
  a. Make sure to mount /tmp/.X11-unix: `-v /tmp/.X11-unix:/tmp/.X11-unix`
  b. Make sure to set the DISPLAY variable correctly: `-e DISPLAY=$(ipconfig getifaddr en0)`
  c. So, for the example `x11-firefox`:

```
open -a XQuartz
IP=$(ipconfig getifaddr en0)
xhost + ${IP}
docker build -t x11-firefox x11-firefox
docker run -e DISPLAY=${IP}:0 -v /tmp/.X11-unix:/tmp/.X11-unix --name x11-firefox x11-firefox
```

That's it.


# Credit where credit is due

The initial idea is from [Fabio Rehm's blog](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/), which addresses this issue for a Linux host system.
Also some of the comments, especially [Pulkit Singhal's](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/#comment-3390799157) helped in trying out different solutions.
There's a lot of stackoverflow questions on the topic, but most are full of outdated or non-macOS answers.
An interesting overview of approaches can be found in [Can you run GUI applications in a Docker container?](https://stackoverflow.com/questions/16296753/can-you-run-gui-applications-in-a-docker-container).
One of the more enlightening, even problem-solving comments was made by [horcle_buzz](https://stackoverflow.com/questions/38686932/how-to-forward-docker-for-mac-to-x11?rq=1#comment84886444_38687836): "Turned out the issue was a mere reboot was necessary."
The Python/Matplotlib example is directly taken from the [animation tutorial](https://matplotlib.org/gallery/animation/strip_chart.html).


# Issues

- Getting pip properly installed is still a magical thing... anyways, the example Dockerfile works.
- The apps have to support X11. Also some docker things don't seem to work properly: e.g. Python is without tkinter, hence the choice of Qt5.


# TODO:

- Test via remote server
- Test with daemonized settings
- Try different docker base images
- Try different host systems
- The big goal: ROS + gazebo on remote machine
