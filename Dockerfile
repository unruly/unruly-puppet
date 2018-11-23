FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
# Update packages
RUN yum clean all && yum update -y && yum clean all
# Install puppet-agent
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && yum -y install puppet-agent

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

# Add smoke test manifests
COPY test_configuration /puppet/modules/test_configuration
# Add all puppet modules
COPY modules /puppet/modules
# Add Hiera Data
COPY hieradata /puppet/hieradata
# Configure Hiera
COPY hiera.yaml /etc/puppetlabs/puppet/hiera.yaml