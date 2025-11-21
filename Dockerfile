#Stable official Java runtime image
FROM eclipse-temurin:17-jdk-focal 

#Working directory inside the container
WORKDIR /app

#Copy the application JAR file to the container
COPY Calculator_app/SimpleCalculator.java /app/SimpleCalculator.java

#Compile the Java application
RUN javac SimpleCalculator.java

#Expose port 8000
#EXPOSE 8000

#Command to run the Java application
CMD ["java", "SimpleCalculator"]
