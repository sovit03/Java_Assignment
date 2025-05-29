# Use official Tomcat 9.0 image
FROM tomcat:9.0

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into Tomcat webapps as ROOT.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

