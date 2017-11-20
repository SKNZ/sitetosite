# Use an official Python runtime as a parent image
FROM jfloff/alpine-python:2.7-onbuild

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
# RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Run app.py when the container launches
CMD route del default && \
    route add default gw cloudgw && \
    python app.py
