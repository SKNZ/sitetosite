# Use an official Python runtime as a parent image
FROM library/nginx

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN cp nginx.conf /etc/nginx/
RUN apt-get update
RUN apt-get -y install dnsutils

# Run app.py when the container launches
CMD sed -ie "s/srv1/$(dig +short pr1_server_1)/" /etc/nginx/nginx.conf; \
    sed -ie "s/srv2/$(dig +short pr1_server_2)/" /etc/nginx/nginx.conf; \
    sed -ie "s/srv3/$(dig +short pr1_server_3)/" /etc/nginx/nginx.conf; \
    sed -ie "s/srv4/$(dig +short pr1_server_4)/" /etc/nginx/nginx.conf; \
    nginx

