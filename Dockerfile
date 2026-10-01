FROM tomcat:11-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/QuickShop.war /usr/local/tomcat/webapps/QuickShop.war

EXPOSE 8080

CMD ["catalina.sh", "run"]