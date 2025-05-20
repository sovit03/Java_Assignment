# Use official Tomcat base image
FROM tomcat:9.0

# Optional: Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR into Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war
