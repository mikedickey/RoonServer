# Dockerfile to install the latest version of RoonServer for Linux x86_64

# Use Ubuntu 15.10 since it has seen the "strongest positive experiences"
FROM ubuntu:15.10

# Based upon RonCH's Dockerfile from https://community.roonlabs.com/t/roon-running-in-docker-on-synology/9979
# and instructions from http://kb.roonlabs.com/LinuxInstall
MAINTAINER mike@mikedickey.com

# Location of Roon's latest Linux installer
ENV ROON_INSTALLER roonserver-installer-linuxx64.sh
ENV ROON_INSTALLER_URL http://download.roonlabs.com/builds/${ROON_INSTALLER}

# Install prerequisite packages
RUN apt-get update \
	&& apt-get install -y curl libav-tools cifs-utils libasound2 \
	&& apt-get clean && apt-get autoclean

# Grab installer
ADD ${ROON_INSTALLER_URL} /tmp

# Fix installer permissions
RUN chmod 700 /tmp/${ROON_INSTALLER}

# Run installer, answer "yes"
CMD printf "y\ny\n" | /tmp/${ROON_INSTALLER} && tail -f /dev/null

# Your Roon data will be stored in /var/roon; /music is for your music
VOLUME [ "/var/roon", "/music" ]
