# Use an official Python runtime as a parent image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt
RUN apt-get update
RUN apt-get install -y net-tools inetutils-ping nano

# Define environment variable
ENV SELF_ID 1
ENV IOT_SERVER "http://10.0.0.99:8080"

# Run app.py when the container launches
CMD route del default; route add default gw gwiot; ./wait-for-it.sh server:8080; bash

