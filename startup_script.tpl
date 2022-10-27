#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
aws s3 cp s3://${s3_bucket_name}/website/index.html /home/ec2-user/index.html
aws s3 cp s3://${s3_bucket_name}/website/resources/css/styles.css /home/ec2-user/styles.css
aws s3 cp s3://${s3_bucket_name}/website/resources/css/reset.css /home/ec2-user/reset.css
aws s3 cp s3://${s3_bucket_name}/website/resources/images/adobo1.jpg /home/ec2-user/adobo1.jpg
aws s3 cp s3://${s3_bucket_name}/website/resources/images/adobo2.jpeg /home/ec2-user/adobo2.jpeg
aws s3 cp s3://${s3_bucket_name}/website/resources/images/filipinoman.jpg /home/ec2-user/filipinoman.jpg
aws s3 cp s3://${s3_bucket_name}/website/resources/images/karekare.jpg /home/ec2-user/karekare.jpg
aws s3 cp s3://${s3_bucket_name}/website/resources/images/lechon.jpg /home/ec2-user/lechon.jpg
aws s3 cp s3://${s3_bucket_name}/website/resources/images/logo.png /home/ec2-user/logo.png
aws s3 cp s3://${s3_bucket_name}/website/resources/images/lumpia.jpg /home/ec2-user/lumpia.jpg
aws s3 cp s3://${s3_bucket_name}/website/resources/images/pancit.jpg /home/ec2-user/pancit.jpg

sudo rm /usr/share/nginx/html/index.html
sudo cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
sudo cp /home/ec2-user/styles.css /usr/share/nginx/html/styles.css
sudo cp /home/ec2-user/reset.css /usr/share/nginx/html/reset.css
sudo cp /home/ec2-user/adobo1.jpg /usr/share/nginx/html/adobo1.jpg
sudo cp /home/ec2-user/adobo2.jpeg /usr/share/nginx/html/adobo2.jpeg
sudo cp /home/ec2-user/filipinoman.jpg /usr/share/nginx/html/filipinoman.jpg
sudo cp /home/ec2-user/karekare.jpg /usr/share/nginx/html/karekare.jpg
sudo cp /home/ec2-user/lechon.jpg /usr/share/nginx/html/lechon.jpg
sudo cp /home/ec2-user/logo.png /usr/share/nginx/html/logo.png
sudo cp /home/ec2-user/lumpia.jpg /usr/share/nginx/html/lumpia.jpg
sudo cp /home/ec2-user/pancit.jpg /usr/share/nginx/html/pancit.jpg

