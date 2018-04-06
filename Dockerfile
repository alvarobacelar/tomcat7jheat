FROM debian

MAINTAINER alvaro@alvarobacelar.com

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
default-jdk unzip

# Configure apache tomcat
ADD http://repo2.maven.org/maven2/org/apache/tomcat/tomcat/7.0.69/tomcat-7.0.69.tar.gz ./
RUN tar xvzf tomcat-7.0.69.tar.gz
RUN mv apache-tomcat-7.0.69 /opt/tomcat7
RUN rm -rf tomcat-7.0.69.tar.gz

ENV JAVA_HOME /usr/lib/jvm/default-java
ENV CATALINA_HOME /opt/tomcat7
ENV PATH $CATALINA_HOME/bin:$PATH

# configure extra
ADD . /home
RUN mv /home/web.xml $CATALINA_HOME/conf/web.xml
RUN mv /home/catalina.properties $CATALINA_HOME/conf/catalina.properties
RUN mv /usr/share/zoneinfo/America/Fortaleza /etc/timezone
RUN mv /home/localtime /etc/localtime
RUN ln -s $CATALINA_HOME /usr/local/tomcat
WORKDIR $CATALINA_HOME

EXPOSE 8080
CMD ["catalina.sh", "run"]
