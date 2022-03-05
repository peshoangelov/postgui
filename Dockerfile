FROM centos:7
COPY PostGUI/ /opt/PostGUI/
RUN yum -y install epel-release && yum -y install npm screen && yum clean all && cd /opt/PostGUI && npm install --no-optional && npm install eslint --no-optional
EXPOSE 8771
WORKDIR /opt/PostGUI
CMD ["npm", "start"]