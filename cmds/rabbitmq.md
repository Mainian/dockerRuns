# rabbit mq

setup rabbitmq with management console; restart unless-stopped
expose queues on host 5672
expose management on host 15672:15672

`docker run -d --hostname my-rabbit --name some-rabbit -e RABBITMQ_DEFAULT_USER=dev -e RABBITMQ_DEFAULT_PASS=dev -p 5672:5672 -p 15672:15672 --restart unless-stopped rabbitmq:3-management`