FROM centos:7
COPY postgrest/ /opt/postgrest/
COPY PostGUI/ /opt/PostGUI/
RUN yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm && yum -y install epel-release postgresql10 && yum -y install npm && yum clean all && cd /opt/PostGUI && npm install --no-optional && npm install eslint --no-optional
EXPOSE 8771/tcp
CMD ["/opt/PostGUI/run.sh"]