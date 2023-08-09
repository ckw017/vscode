# Experimental ubi8 image that's compatible with Anyscale
FROM registry.access.redhat.com/ubi8/ubi:latest
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Install basic dependencies
RUN set -ex \
     && dnf update -y -q \
     && dnf install -y -q sudo wget zip unzip git python3.9 make gcc gcc-c++ \
     && dnf clean all \
     && rm -rf /var/cache/yum

# Setup ray user with sudoer permissions.
# Note that ray user should be (uid: 1000, gid: 100) to work with shared file
# systems.
RUN useradd -ms /bin/bash -d /home/ray ray --uid 1000 --gid 100 \
     && usermod -aG wheel ray \
     && echo 'ray ALL=NOPASSWD: ALL' >> /etc/sudoers

# Switch to ray user
USER ray
ENV HOME=/home/ray

# Setup Python virtual env
RUN python3.9 -m venv --system-site-packages /home/ray/virtualenv
ENV PATH=/home/ray/virtualenv/bin:$PATH
RUN sudo mkdir -p $(python -c 'import site; print(site.getsitepackages()[0])')

# VS Code build dependencies

RUN sudo wget https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official -P /etc/pki/rpm-gpg/
RUN sudo rpm -vv --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Official
RUN sudo dnf -y -q module disable nodejs && sudo dnf -y -q module enable nodejs:16 && sudo dnf -y -q install nodejs nodejs-nodemon nodejs-full-i18n npm && sudo npm install --global yarn
RUN sudo yum -y --repofrompath=centos,http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/ groupinstall "Development Tools"
RUN sudo yum -y --repofrompath=centos,http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/ install libX11-devel.x86_64 libsecret-devel krb5-devel
RUN sudo yum -y --repofrompath=centos,http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/ install libxkbfile
RUN sudo yum -y --repofrompath=centos,http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/ install libxkbfile-devel
