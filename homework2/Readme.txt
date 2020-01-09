docker image pull ubuntu:14.10
# дърпам имиджа
docker container run -it ubuntu:14.10
# пускам контейнер от имиджа
-----------------------------------
Обмен на шаблони
#Стартирам контейнер от шаблона Alpine
docker container run -it --name my-alpine alpine

Експортвам контейнера като tar архив за да го
използвам като image по-късно за вдигането на друг контейнер
 docker container export -o my-alpine.tar my-alpine

След това импортвам image-a от архива, като имам предвид, че CMD , ENV
свойствата не се запазват.
docker image import my-alpine.tar --change "CMD /bin/sh" my-new-alpine

Рънвам контейнер от новият image.
docker container run -it my-new-alpine
----------------------------------------

Архив и трансфер на шаблони

Пулвам имиджа
docker image pull busybox
Създавам архив от него
docker image save -o busybox.tar busybox
И зареждам имиджа
docker image load -i busybox.tar
----------------------------------------
Създаване на шаблон от контейнер

Стартирам си контейнер
docker container run --name=my-ubuntu -it ubuntu
Вдигам имидж от контейнера
docker container commit --author "Alex" my-ubuntu new-ubuntu

Вдигам контейнер от същият този имидж

docker container run -it new-ubuntu

-------------------------------------------

Създаване на шаблони от файлове

    Създаване от heredoc файл

docker image build -t alp-htop - << EOF
FROM alpine
RUN apk --no-cache add htop
EOF

(Където ЕOF  е End Of File и се задава като ограничител до къде
ще описваме харектеристиките на имиджа)

Рънвам контейнера
docker container run -it alp-htop
От него рънвам htop след което излизам от него и от контейнера
--------------------------------------------

Dockerfile

Създавам Dockerfile след което записвам в него чрез vi
FROM ubuntu
LABEL maintainer="Alex"
RUN apt-get update
RUN apt-get install -y nginx
ENTRYPOINT ["/usr/sbin/nginx","-g","daemon off;"]
EXPOSE 80

Build-вам имидж от него
docker image build -t nginx-1 .
(gledam da ne zabravq tochkata)

Run-вам контейнер
docker container run -d -p 8080:80 --name web-1 nginx-1
--------------------------------------

ENTRYPOINT и CMD

Създавам нов Докерфаил
FROM busybox
LABEL description="ENTRYPOINT vs CMD demo" maintainer="SoftUni Student"
ENTRYPOINT ["ping", "-c", "4"]
CMD ["www.softuni.bg"]

Създавам имиджа
docker image build -t pinger .

Създавам контейнера
docker container run --name=p1 pinger
Създавам още един
docker container run --name=p2 pinger www.softuni.bg
------------------------------------

Почиствам
docker container stop $(docker container ls -q)
docker container prune
docker image rm $(docker image ls –q)