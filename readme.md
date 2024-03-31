RunBook#30.03_2024-01_04_2024_Kostiantyn_Derevianchenko

Task1 -   \Create bash script for output unie file names from both catalogs\
Task2 -   \describe the construction of ci-cd using the provided pipelines\
Task3 -   \How to up microservices in docker container trough docker-compose\
Task3_1 - \How to up microservices in docker container trough docker-compose on the production server\


Orig tasks list:

Завдання 1
-----------------
За допомогою bash команди чи bash скрипту вирішити наступну задачу (додаткова реалізація за допомогою python чи за допомогою іншої мови програмування буде плюсом): необхідно вивести всі назви файлів з двох директорій так щоб вони були унікальними (Врахувати негативні кейси). У разі необхідності попередніх налаштувань, надати step by step інструкцію.
Приклад:
Наявна директорія my_dir_1. З наступним контентом:
my_dir_1
file1.txt
file2.txt
file3.txt
Наявна директорія my_dir_2. З наступним контентом:
my_dir_2
file2.txt
file4.txt
Бажаний результат:
file1.txt
file2.txt
file3.txt
file4.txt

-----------------------------------------------------------------------------------------------------------------
My code bash script project location:(/main-server/check_unique_files/detectuniquefiles.sh)
This script can detected unique file names in both catalogs(my_dir_1; mmy_dir_2)

!!!Notification! If you haven't in your test environment catalogs (my_dir_1; mmy_dir_2) and needed
files in this catalogs, before run script need uncomment bash script string? for create this catalogs and files 

from:

#mkdir -p my_dir_1 my_dir_2 && cd my_dir_1 && touch file1.txt  file2.txt  file3.txt && cd .. && cd my_dir_2 && touch  file2.txt  file4.txt && cd ..

to:

mkdir -p my_dir_1 my_dir_2 && cd my_dir_1 && touch file1.txt  file2.txt  file3.txt && cd .. && cd my_dir_2 && touch  file2.txt  file4.txt && cd ..

#Save file ,exit and run this file:

./detectuniquefiles.sh


################################################################
#!/bin/bash
#clean final report
#If you see this alerts:
#-------------------------ls: cannot access 'my_dir_1': No such file or directory----------------------------------
#-------------------------ls: cannot access 'my_dir_2': No such file or directory----------------------------------
# maybe you haven't catalogs and files for testing, you can uncomment next string! After that test catalogs and files will be created!
#mkdir -p my_dir_1 my_dir_2 && cd my_dir_1 && touch file1.txt  file2.txt  file3.txt && cd .. && cd my_dir_2 && touch  file2.txt  file4.txt && cd ..
echo "" > compare.txt
# add filenames from catalog *my_dir_1* to file compare.txt
ls my_dir_1 >> compare.txt
# add filenames from catalog *my_dir_2* to file compare.txt
ls my_dir_2 >> compare.txt
#sort \ drop double \ output
echo | sort compare.txt | uniq | sed '/^$/d' > list.txt
#cat list.txt # uncomment if need first symbol string '#' for debug
for list in $(cat list.txt)
do
echo $list
echo ""
done
rm list.txt
rm compare.txt
################################################################
Also you can start file from project GIT catalog /main-server/check_unique_files/detectuniquefiles.sh

#If you need advanced privelege for execute this file , go to catalog /main-server/check_unique_files/ 
and after that run command chmod +x detectuniquefiles.sh
Run the file again.(./detectuniquefiles.sh) 

Done.task 1 finished
------------------------------------------------------------------------------------------------------------------
Завдання 2
Побудуйте власну послідовність дій для двох логічних блоків та обґрунтуйте свій вибір. Об'єднайте деякі кроки разом, котрі вважаєте треба виконувати як один процесс у випадку ci-cd. Як результат отримати послідовність для майбутнього вибудовування ci-cd процесів для кожного з блоків.
Блок 1
unit tests (quick)
code linters
publishing to environment
build code
integration tests (take a lot of time)
docker image creating
Блок 2
unit tests (quick)
code linters
release new package version in registry of packages
build code
create git tag for current branch
publish static content for preview (static content is creating when run specific command for generate it)

------------------------------------------------------------------------------------------------------------------
I have two block instructions ci - cd, but I created single instruction.
It piplines can separate on depens steps or blocs if it will be need.
For full understanding steps piplines examples, I will do it on the Jenkins job: /step by step/ after changed git branch project or new
commit and push to git! 
-------------------------------------------------------------------------------------------------------------------
1. After push to git new code/ commit to git and push/-it will can be repaire procedure /rollback / Release new package version in registry of packages 
/coders writing new code or adding changes to code after release./

2. Create git tag for current branch and push to git - Jenkins will waiting changed state project or periodical
clone full project to his workspace project place
(crontab jenkins job tasks or every two min check updated git branch via connection plugins ssh \
or webhook connected)

3. Integration tests (take a lot of time) -  single test each code components \ methods- if detected bugs
or anomalies - then Code linters 

4. Code linters - if code problems detected(Jenkins job) - stop continue \build \ push report and send notificate
to all team members, if not -continue pipeline

5. Unit tests (quick) - quick test in Jenkins - it can do compare shavan heshsumm(sha-256) code files for examle
or check functional the code and waiting output result after code finish 

6. code linters - if code problems detected - as previouse same piplines block- stop task, and send notification
to all team members, if not -continue pipeline

7. build code- we can deploy code to stage srever(mounted catalogs to ran docker container)
for preview and check webserver work via rsync \ scp and other. you need change the method deliver code
(I think that it will be depends copy operation,because no need integrate updaded code to body docker images and
every time rebuild docker image) copy method, we can use for it jenkins plugins, or manually create linux task
for deploy it.
After deliver code will be updated or add to catalogs , which mounted to docker-compose(ran docker containers)? 
to  server for examples or backend for eхamples

8. Docker image creating /rebuilding (Dockerfile) if it was updated for add new packet or another reason.


9. Publish static content for preview (static content is creating when run specific command for generate it)
in stage 
If on the stage server we got working web server, the code will be deploy and update on the production server

10. Publishing to environment -deploy to production server for reload data in webserver UI or backend app update 

11. After release new package version in registry of packages - we need send it advanced tasks to coders before
step 1 


Done.task 2 finished
---------------------------------------------------------------------------------------------------------


Tasks 3.1 \ 3.2
######################################################################################
Завдання 3
Створити docker-compose файл який би підняв веб сервер на php. 
Він складатиметься з двух images: nginx та php-fpm.
Налаштувати його так, щоб була можливість вести розробку цього веб серверу локально.
Створити docker-compose для цього ж серверу для прод оточення. І описати флоу як буде
вестись розробка і ci/cd процес для цього серверу.  
######################################################################################

--------------------------------------------------------------------------------------------------
Task 3.1:
---------------

My environment:
network device: Mikrotik RB 2011

Hardware : HP laptop cpu: core i5  \ ram 16   \system ssd 480   \ advanced ssd 2TB

ROOT laptop OS: Windows 10 v. 22h2 (19045.4170)

Software for testing microservices:

Hashicorp Vagrant(v:2.2.19) +Oracle Virtualbox(v. 6.1):
#################################################################################
first containers was builded and started in Ubuntu-bionic (earlier vagrant image pull and started) 
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.6 LTS
Release:        18.04
Codename:       bionic


last pulled containers stated and tested ubuntu 20.04  (vagrant image os: bento/ubuntu-20.04)

Distributor ID: Ubuntu
Description:    Ubuntu 20.04.2 LTS
Release:        20.04
Codename:       focal


--------------------------------------------------------------------------------------------------------

Steps for build VM:

1. Vagrant up ubuntu server via command: vagrant init 'image tag vagrant'
(for example: 'vagrant init bento/ubuntu-20.04') trough cmd

2. 'vagrant up'

#It my example started server via Vagrant:
#################################################
D:\>cd D:\VM_Platforms_Backups\VAGRANT\Bionic_Ubuntu_64

D:\VM_Platforms_Backups\VAGRANT\Bionic_Ubuntu_64>vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'ubuntu/bionic64' version '20230607.0.0' is up to date...
==> default: Clearing any previously set forwarded ports...
==> default: Fixed port collision for 22 => 2222. Now on port 2200.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: bridged
==> default: Forwarding ports...
    default: 22 (guest) => 2200 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2200
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Remote connection disconnect. Retrying...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default:
    default: Guest Additions Version: 5.2.42
    default: VirtualBox Version: 6.1
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
    default: /vagrant => D:/VM_Platforms_Backups/VAGRANT/Bionic_Ubuntu_64
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.
#################################################

3. 'vagrant ssh' #(check jump ssh to created vm) 
#examle jump ssh to started server:

###############################################################
D:\VM_Platforms_Backups\VAGRANT\Bionic_Ubuntu_64>vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Mar 30 17:23:18 UTC 2024

  System load:                    0.95
  Usage of /:                     13.4% of 38.70GB
  Memory usage:                   59%
  Swap usage:                     0%
  Processes:                      129
  Users logged in:                0
  IP address for enp0s3:          10.0.2.15
  IP address for enp0s8:          XX.XX.XX.XX      
  IP address for br-619a6b7d7b5b: 172.26.0.1
  IP address for docker0:         172.17.0.1

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Infrastructure is not enabled.

13 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

111 additional security updates can be applied with ESM Infra.
Learn more about enabling ESM Infra service for Ubuntu 18.04 at
https://ubuntu.com/18-04

Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Mar 30 17:23:18 UTC 2024

  System load:                    0.95
  Usage of /:                     13.4% of 38.70GB
  Memory usage:                   59%
  Swap usage:                     0%
  Processes:                      129
  Users logged in:                0
  IP address for enp0s3:          10.0.2.15
  IP address for enp0s8:          XX.XX.XX.XX
  IP address for br-619a6b7d7b5b: 172.26.0.1
  IP address for docker0:         172.17.0.1

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Infrastructure is not enabled.

13 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

111 additional security updates can be applied with ESM Infra.
Learn more about enabling ESM Infra service for Ubuntu 18.04 at
https://ubuntu.com/18-04

New release '20.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Sat Mar 30 11:06:03 2024 from 10.0.2.2
vagrant@ubuntu-bionic:~$

###############################################################


4. vagrant halt (stpop and disable vm for change vasgrant setting. I switched network vm to bridge mode,
that my routere can give dhcp network address for lan card my laptop. I added this command to vagrantfile:
config.vm.network :public_network, :bridge => "Realtek PCIe GbE Family Controller"

5. back to cmd and run: 'vagrant up'

6.  'vagrant ssh'

7 sudo -s

8. whoami
(output: root@vagrant:/home/vagrant#)

9. apt-get update


10. Install next packets(if you haven't it):
################################

apt-get install nano -y 

apt-get install vim -y

apt-get install mc -y

apt-get install htop -y

apt-get install atop -y

apt-get install net-tools -y
##############################

11. Install the docker:
manual:(https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)

11.x  Run step by step this commands:(for all question commands you need input: 'Y' or 'y')

sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

apt-cache policy docker-ce    #you can see docker candidate ver

sudo apt install docker-ce    #docker will be installed

sudo systemctl status docker  #you can see current state the docker service


sudo usermod -aG docker ${USER}  # add user to sudo group if you didn't logon as root


su - ${USER}                     # apply previouse step

docker                           3 check output- if docker installed you will see:

fragment output example:

###########################################################
Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Common Commands:
  run         Create and run a new container from an image
  exec        Execute a command in a running container
  ps          List containers
  build       Build an image from a Dockerfile
  pull        Download an image...
  
#############################################################

Done. Docker installed!

12. Install the docker-compose:
manual:(https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)

12.x  Run step by step this commands:

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version   # you can see output about installed docker-compose version:

###############################################

docker-compose version 1.29.2, build 5becea4c

###############################################

Done docker-compose installed

13. cd /home/vagrant/    # you need go to the current vm user home catalog( You can have another name last catalog)

14. mkdir -p main-server  #create the project catalog and check it 'ls -l'

##############################################################

output: drwxr-xr-x 2 root root 4096 Mar 30 13:48 main-server 

##############################################################

15.cd main-server/ #go to created catalog

16. mkdir -p Backup nginx_serv php_fpm_serv  # create multi-catalogs in main-server catalog and check 'ls -l'

output example:
#########################################################
total 12
drwxr-xr-x 2 root root 4096 Mar 30 13:53 Backup
drwxr-xr-x 2 root root 4096 Mar 30 13:53 nginx_serv
drwxr-xr-x 2 root root 4096 Mar 30 13:53 php_fpm_serv
########################################################

17.touch docker-compose.yml #create the file docker-compose.yml (this file later will start our services: nginx / php / mysql / phpadmin)

18. ls -l  #current root tructure view in catalog main server

output example:

#############################################################

total 12
drwxr-xr-x 2 root root 4096 Mar 30 13:53 Backup
-rw-r--r-- 1 root root    0 Mar 30 13:59 docker-compose.yml
drwxr-xr-x 2 root root 4096 Mar 30 13:53 nginx_serv
drwxr-xr-x 2 root root 4096 Mar 30 13:53 php_fpm_serv

#############################################################

19. nano docker-compose.yml   # open file for edit and input it:

!!!!Notification: string '#############....'  I used as separator between instructions \ code and output examples!
There is no need to add these symbols to the file without comments. This single symbol is also a way to disable
certain commands and actions in the file! Thanks!

###################################################################

version: '3.3'
services:
     nginx:
#        image: nginxapp
        container_name: nginxapp
        build:
          context: ./nginx_serv/
        restart: always
        ports:
         - '80:80'
        volumes:
              - ./nginx_serv/nginx_conf/conf.d:/etc/nginx/conf.d
              - ./nginx_serv/app/:/var/www/html/
        
        networks: 
            - main-server_docker-lesson

       
      
     php_fpm:
#      image: php_fpm
       container_name: php_fpm
       build:
         context: ./php_fpm_serv/
       restart: always
       ports:
         - '9000:9000'
       volumes:
          - ./php_fpm_serv/app/:/var/www/html/
#         - ./nginx_serv/app/:/var/www/html/  
       networks:
           - main-server_docker-lesson

     db: 
       image: mysql 
       command: --default-authentication-plugin=mysql_native_password 
       restart: always 
       ports:
         - '3306:3306'
       environment: 
          MYSQL_ROOT_PASSWORD: TestSkuljoba2024!
    
       networks:
          - main-server_docker-lesson 


     phpmyadmin: 
       image: phpmyadmin 
       restart: always 
       ports: 
         - 8080:80 
       environment: 
         - PMA_ARBITRARY=1

       networks:
          - main-server_docker-lesson

networks:
  main-server_docker-lesson:
     driver: bridge

###########################################################################

20. Save and close this file and run the next commands(21 \21.1) 
#Your current location before start first command  should be in catalog'main-server' # Check it!

21. cd nginx_serv && mkdir -p Backup app  nginx_conf && touch Dockerfile && cd ..

21.1 cd nginx_serv/nginx_conf && mkdir -p conf.d && touch conf.d/default.conf && cd .. && cd ..

# check created subcatalog in nginx_serv , run the command: 'ls-l nginx_serv/'
example output:

#######################################
total 12
drwxr-xr-x 2 root root 4096 Mar 30 14:20 app
drwxr-xr-x 2 root root 4096 Mar 30 14:20 Backup
-rw-r--r-- 1 root root    0 Mar 30 14:20 Dockerfile
drwxr-xr-x 2 root root 4096 Mar 30 14:20 nginx_conf
#######################################

22. Now our current catalog  '/home/vagrant/main-server#'     
# if you having another location now, go to catalog 'mainserver' before input the next command(23):

23. cd php_fpm_serv/ && mkdir -p app && touch Dockerfile hello.php && cd .. 
# run command and check new files and catalogs in ''

example output:

#############################################
total 4
drwxr-xr-x 2 root root 4096 Mar 30 14:29 app
-rw-r--r-- 1 root root    0 Mar 30 14:29 Dockerfile
-rw-r--r-- 1 root root    0 Mar 30 14:29 hello.php

#############################################

24. check your current location in console # 'pwd' we need start next command from catalog 'main-server'
#if you have another location, need return to catalog  'main-server'.

Soon we run the command for check docker networks! 
# it your output may be you will need later for compare with new docker bridge network later

25. docker network ls   # run the command and you can see current docker networks!
#Later we will create new bridge network for our docker containers and add this network name and network
configuration to docker-compose.yml

example output current docker networks:

#############################################
NETWORK ID     NAME      DRIVER    SCOPE
7684d5464b18   bridge    bridge    local
54e2e0a0791d   host      host      local
4a56da164e69   none      null      local
############################################

26. Next we will create bridge docker network for our docker containers, 
that link between it containers to depends microservices will via container names in docker compose,
we willn't attach ip addresses to configs applications! for that need add our new bridge network.
Run next command(27)

27.  docker network create --driver bridge main-server_main-server_docker-lesson
# after command you can check again commandand, you will see list networks run :'docker network ls'

example output:

########################################################################
NETWORK ID     NAME                                    DRIVER    SCOPE
7684d5464b18   bridge                                  bridge    local
54e2e0a0791d   host                                    host      local
2111f054e742   main-server_main-server_docker-lesson   bridge    local
4a56da164e69   none                                    null      local

#########################################################################

As you see, bridge docker network('main-server_main-server_docker-lesson ') was added as bridge docker network,
and up. But later we need also add to this network our container names, that we already have in docker-compose.yml:
( container_name: nginxapp and container_name: php_fpm ) 
!!!Notificatio! We can add this names to network bridge only after first start docker containers with this names! 

28. Now we will add configs and codes to created files! 

29. Firstly next step we can add configuration to 'default':

30. nano nginx_serv/nginx_conf/conf.d/default.conf # open file config nginx for edit and add this :

###########################################################################
server {
    listen 80;
    listen [::]:80;
    root /var/www/html;

    location / {разное
        index index.php index.html index.htm;
    }

    location ~ \.php$ {
        fastcgi_pass php_fpm:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}

###########################################################################
Save file and exit from editor

As you can see , first block this config started listen port 80, and up resolv to nginx htm ; html files
after web requsts. Next config line describes the location files index.php ; index.htm ; index.html for find
after requests, and next bloc configuration will resolve requests ro our second container with php_fpm.
As you see we didn't use ip addresses, but we will use for connections between containers
in this configuration name 'php_fpm' docker container in line 'fastcgi_pass', 
which will be added to bridge docker network 'php_fpm:9000;'

31. next we add test *.html and *.php files for next test server to catalogs , which will be mounted to 
docker containers after start docker-compose.yml

32. nano nginx_serv/app/index.html 
#current location - catalog 'main-server'.creating the index.html and you need add next code to this file:

########################################
<html>
<head>
<title>Hello!</title>
</head>
<body>
	<H1>Hello from nginx!</H1>
	<P> Test html nginx </P>
</body>
</html>

########################################  
Save file and exit from editor

32.1 #current location - catalog 'main-server'.Creating the index.php!
You need run next command:

nano php_fpm_serv/app/index.php #add next code to the file index.php :

##############################

<?php

echo "Hello from PhP_fpm!\n";

##############################
Save file and exit from editor

We can see later this web outputs last created files(index.gtml ; index.php), when we will
send web request to browser trough ip adress, which we got for our root server,
created trough vagrant or got from GIT.
###########################################################################################
!!!!Notification! If you clone git repository for start project from your office
to remote server or remote Vm, perhaps you already know ip address remote server or Vm.
Aso you can help about this information drom yout team lead or office sysadmin! Then you
no need run next steps for identificate your ip address root project server! 
###########################################################################################
If you created and up server in home   
So, if we need got ip adress in youre home environment for this server from dhcp our router
and building now this project? continue please next steps for detect ip address your test 
your project server VM:

Input the command:

'ip address' or 'ifconfig' in linux console your project server
 you will see a lot of addresses, but you need for test requests find ip address ,
from your home router subnet! If you don't know your home router subnets and ip adresses area, which used 
your home network devices and mobile phones via wifi, you can install windows application for detect and compare
your ip addresses and subnet. It ''advanced ip scanner'for example.  Push the button 'free download'
After file will downloaded - start it and push button 'scan' after that you will see your  ip adresses 
(https://www.advanced-ip-scanner.com/en/)
!!!You willn't need install it, you can change only 'run' application after start? no need install it to your windows system! 

After scan my routers network I see a lot of addresses.. for example:
####################
192.168.1.3

192.168.1.5

192.168.1.6
####################

I need find in my linux server same address via command 'ip address'
For example it will ip: 192.168.1.133 , we can use it example address
from my side for check our webservers nginx an php_fpm!
But you will have another address! You need find and know this your ip address,
and use it your ip address for next web requests! 

32. Next we will edit our Dockerfiles in project and add command to this files!
This files will be need for build and create docker images and after that will
be started to docker containers which willbe include our previouse our files trough
mounted docker-compose catalogs with our data.
So, check youre current location on the project server! You should be stopped now 
in catalog 'main-server'- it our root project catalog, as you remember. If you have
another current location, need back to this catalog, run next command, and add the code
to Dockerfiles.

33. nano nginx_serv/Dockerfile  # edit Dockerfile and add next code:

######################################################################################

FROM ubuntu:20.04
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sleep 30
RUN apt-get install htop -y
RUN apt-get install atop -y
RUN apt-get install vim -y
RUN apt-get install net-tools -y
RUN apt-get install mc -y
EXPOSE 80
EXPOSE 443
RUN apt-get install nginx -y
COPY ./nginx_conf/conf.d/default.conf /etc/nginx/sites-available/default
ENTRYPOINT ["nginx", "-g", "daemon off;"]

#######################################################################################
Save file and exit from editor.

!!!!!Notification! I created this project from ubuntu image, because later probably
this system will be need for me as full system for advanced microservices, which
need run on this server! 
We could did this project lighters and add to this file only nginx service for the light
os in docker image (for examle:alpine linux), but some our commands after start build
docker images willn't work, and perhaps we will need advanced linux tools,
installed after build docker images and start docker containers. 
This tools can help check the networks, check overload system on the containers
and will be need for other check!

33. nano php_fpm_serv/Dockerfile  # edit Dockerfile and add next code:

#######################################

FROM php:8.3-fpm
COPY ./hello.php /var/www/
RUN apt-get update
RUN apt-get install -y iputils-ping
RUN apt-get install nano -y
RUN apt-get install htop -y
RUN apt-get install atop -y
RUN apt-get install mc -y
RUN apt-get install net-tools -y
RUN apt-get install telnet -y


#######################################

Save file and exit from editor.
 
 
34. Now we will start docker-compose.yml, that will be build our micro-services.
After start this services shouldbe created 4 docker containers:
nginxapp ; php_fpm ; sql  ; phpmyadmin .

!!!Notification! Last two services(sql ; phpmyadmin) created and added to docker-compose.yml and started,
because later you will need working with sites, which will be have dynamical structure web resource.
For this sites perhaps will be need started database on your server and easy access to this database via web.
If you no need start this advanced containers, you can cut from docker-compose.yml next commands
and save your file! You can cut this blocs from docker-compose.yml and save it file 

############################################################
    db:
       image: mysql
       command: --default-authentication-plugin=mysql_native_password
       restart: always
       ports:
         - '3306:3306'
       environment:
          MYSQL_ROOT_PASSWORD: TestSkuljoba2024!

       networks:
          - main-server_docker-lesson


    phpmyadmin:
       image: phpmyadmin
       restart: always
       ports:
         - 8080:80
       environment:
         - PMA_ARBITRARY=1 
############################################################
Save file and exit from editor.

!!!!! If you will be build all previouse services with database and phpmyadmin,
I recommend replace password on the string'MYSQL_ROOT_PASSWORD' to your another
and longer password taht I created.I can includ to this password special symbols keyboard.

Check youre current location on the project server! You should be stopped now 
in catalog 'main-server'- it our root project catalog, as you remember. If you have
another current location, need back to this catalog, run next command, and add the code
to Dockerfiles.

35.Next command started docker-compose file, after that docker-containers
should be started! Run the command 'docker-compose up -d' from catalog 'mainserver'':

docker-compose up -d

##########################################################################################################
!!!!!!! Troubleshooting:
If first two containers(nginxapp ; php_fpm) willn't created after previouse command,
you can go to catalogs which have Docker files (/main-server/nginx_serv/ ; /main-server/php_fpm_serv/)
and manually build this containers.

Example 1 - for manual start build nginx docker container:
Go to catalog /main-server/nginx_serv/ and run the command:

docker build -t nginxapp . 

After that container for nginx server should be created.
You can check created your images after run command 'docker images'
After that you can see list names and tag builds your docker images.

Same build container operation need start for php_fpm service.

Example 2 - for manual start build php_fpm docker container:
Go to catalog /main-server/php_fpm_serv/ and run the command:

docker build -t nginxapp .

After that container for php server should be created.
You can check created your images after run command 'docker images'
After that you can see list your docker images.

After that we need edit our /main-server/docker-compose.yml again!!!
We will edit only block command , depending on the problems of auto-assembly,
I will create one image or another. In an example I will show how to edit the
file to start docker containers for each of the first two services: for nginx and php-fpm

For auto start images from docker-compose.yml, after your manually build for nginx service
You need comment with help symbol '#' autobild string and and uncomment string 'image:'

for first block(nginxapp) docker-compose.yml file it will look so:

Example 1 - edit block nginx service:

################################################################################################################

 version: '3.3'
services:
     nginx:
        image: nginxapp                                            # This string was uncomment             
        container_name: nginxapp
#       build:													   # This string was disable after comment '#'                               
#         context: ./nginx_serv/                                   # This string was disable after comment '#' 
        restart: always
        ports:
         - '80:80'
        volumes:
              - ./nginx_serv/nginx_conf/conf.d:/etc/nginx/conf.d
              - ./nginx_serv/app/:/var/www/html/

        networks:
            - main-server_docker-lesson
 



################################################################################################################

Save file and exit from editor.

Same operatioan you will need do, If you have the problem auto build docker image for php-fpm

Example 2- edit block php_fpm service:

################################################################################################################

     php_fpm:
#      image: php_fpm
       container_name: php_fpm
       build:
         context: ./php_fpm_serv/
       restart: always
       ports:
         - '9000:9000'
       volumes:
          - ./php_fpm_serv/app/:/var/www/html/
#         - ./nginx_serv/app/:/var/www/html/
       networks:
           - main-server_docker-lesson

################################################################################################################
Save file and exit from editor.

Done troubleshooting bloc.
----------------------------------------------------------------------------------------------------------------
36. Now we need go back to our root project directory (/main-server)

37. docker-compose up -d  # Start coker-compose again

38 docker ps              # You should be see four up docker containers.

39. Next we need add our containers names to docker bridge network:

39.1  
