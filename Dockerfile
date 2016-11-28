# Dockerfile to install the latest version of RoonServer for Linux x86_64

# Using latest debian, since 15.10 still regularly crashes
FROM debian:jessie

# Based upon RonCH's Dockerfile from https://community.roonlabs.com/t/roon-running-in-docker-on-synology/9979
# and instructions from http://kb.roonlabs.com/LinuxInstall
MAINTAINER mike@mikedickey.com

# Location of Roon's latest Linux installer
ENV ROON_INSTALLER roonserver-installer-linuxx64.sh
ENV ROON_INSTALLER_URL http://download.roonlabs.com/builds/${ROON_INSTALLER}

# These are expected by Roon's startup script
ENV ROON_DATAROOT /var/roon
ENV ROON_ID_DIR /var/roon

# Install prerequisite packages
RUN apt-get update \
	&& apt-get install -y curl bzip2 libav-tools cifs-utils libasound2 \
	&& apt-get clean && apt-get autoclean

# Grab installer and script to run it
ADD ${ROON_INSTALLER_URL} /tmp
COPY run_installer.sh /tmp

# Fix installer permissions
RUN chmod 700 /tmp/${ROON_INSTALLER} /tmp/run_installer.sh

# Run the installer, answer "yes" and ignore errors
RUN /tmp/run_installer.sh

# Your Roon data will be stored in /var/roon; /music is for your music
VOLUME [ "/var/roon", "/music" ]

# This starts Roon when the container runs
ENTRYPOINT /opt/RoonServer/start.sh
