echo "> 현재 구동 중인 RunToU 애플리케이션 pid 확인" >> /home/ec2-user/app/log/runtou/deploy.log

CURRENT_PID=$(pgrep -f '.jar$')

echo -e "> 현재 구동 중인 애플리케이션 pid\n$CURRENT_PID" >> /home/ec2-user/app/log/runtou/deploy.log

if [ -z "$CURRENT_PID" ]; then
  echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다." >> /home/ec2-user/app/log/runtou/deploy.log
else
  echo -e "> kill -15 $CURRENT_PID" >> /home/ec2-user/app/log/runtou/deploy.log
  sudo kill -15 $CURRENT_PID
  sleep 5
fi

echo "> NGINX 프로세스 pid 확인" >> /home/ec2-user/app/log/runtou/deploy.log

NGINX_PID=$(pgrep -f nginx)

if [ -z "$NGINX_PID" ]; then
  echo "> 현재 NGINX가 실행 중이지 않습니다. 따라서, NGINX를 실행합니다." >> /home/ec2-user/app/log/runtou/deploy.log
  sudo service nginx start
else
  echo "> 이미 NGINX가 실행 중입니다." >> /home/ec2-user/app/log/runtou/deploy.log
fi

echo "> 새 애플리케이션 배포" >> /home/ec2-user/app/log/runtou/deploy.log
nohup java -jar \
  -Dspring.config.location=/home/ec2-user/app/s3-deploy/application-stage.properties \
  -Dspring.profiles.active=stage \
  /home/ec2-user/app/s3-deploy/runtou*.jar \
  >> /home/ec2-user/app/log/runtou/application.log 2>&1 &

echo "> 서버 애플리케이션 로그 파일: /home/ec2-user/app/log/runtou/application.log" >> /home/ec2-user/app/log/runtou/deploy.log