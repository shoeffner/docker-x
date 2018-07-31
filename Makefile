LOCAL_IP=$(shell ipconfig getifaddr en0)
CONTAINERS=$(shell ls -d */ | sed -e "s/\///g" | sed -e "s/x11-//g")

%:
	@if [ "" == "$*" ]; then \
		echo "Please make one of \n\t${CONTAINERS}" && false; \
	fi
	docker build -t x11-$* x11-$*
	open -a XQuartz
	xhost + ${LOCAL_IP}
	docker run -e DISPLAY=${LOCAL_IP}:0 -v /tmp/.X11-unix:/tmp/.X11-unix --name x11-$* x11-$*

clean:
	- $(foreach container, ${CONTAINERS}, $(shell docker container rm x11-${container}))
	- $(foreach image, ${CONTAINERS}, $(shell docker image rm x11-${image}))
