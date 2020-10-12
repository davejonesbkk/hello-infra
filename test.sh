#!/bin/bash

touch /tmp/test.txt

echo "hello world" > /tmp/test.txt

sudo yum update -y

sudo yum install -y docker

sudo service docker start



