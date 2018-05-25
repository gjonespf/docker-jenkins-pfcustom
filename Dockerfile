FROM jenkins/jenkins:lts

# if we want to install via apt
USER root

# Base stuff required
RUN apt-get update \
    && apt-get install curl gnupg apt-transport-https 

# PowerShell UBU
# RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
#     && curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list \
#     && apt-get update \
#     && apt-get install -y powershell

# Powershell Stretch
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list' \
    && apt-get update \
    && apt-get install -y powershell

USER jenkins

# Plugins
# TODO: Clean out this plugins list, to just the bare minimum needed
COPY config/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# COPY config/init.groovy.d/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# lets configure Jenkins with some defaults
# COPY config/*.xml /usr/share/jenkins/ref/

# TODO: Use Jenkins CAAS project
# TODO: Script to run and Copy bootstrap files?
# For now, rely on /usr/share/jenkins/ref/


