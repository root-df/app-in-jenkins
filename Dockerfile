# Pull base image 
From tomcat:8-jre8 

# maintainer 
MAINTAINER "kserge2001@yahoo.fr" 
COPY ./webapp.war /usr/local/tomcat/webapps
