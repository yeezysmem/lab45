 


#! /bin/sh
yum update -y
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
chkconfig docker on

sudo docker pull yeezysmem/lab4

sudo docker pull containrrr/watchtower

sudo docker run -d -p 80:80 yeezysmem/lab4

sudo docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower -i 60