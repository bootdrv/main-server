RunBook#30.03_2024-01_04_2024_Kostiantyn_Derevianchenko 

##################################################################
Task:
Need up nginx+php-fpm+sql+phpmyadmin in separate docker containers.
##################################################################

--------------------------------------------------------------------------------------------------


My environment:
network device: Mikrotik RB 2011

Hardware : HP laptop cpu: core i5  \ ram 16   \system ssd 480   \ advanced ssd 2TB

ROOT laptop OS: Windows 10 v. 22h2 (v.19045.4170)

Software for testing microservices:

Hashicorp Vagrant(v:2.2.19) +Oracle Virtualbox(v. 6.1):
#################################################################################
first containers was builded and started in Ubuntu-bionic (earlier vagrant image pulled and started) 
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


4. vagrant halt (stop and disable vm for change vagrant setting. I switched network vm to bridge mode,
that my router can give to rent ip address from dhcp server for lan card my laptop. I added this command to vagrantfile:
config.vm.network :public_network, :bridge => "Realtek PCIe GbE Family Controller"

5. back to cmd and run: 'vagrant up'

6. 'vagrant ssh'

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

12.1  Run step by step this commands:

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

###################################################################

!!!!Notification: string '#############....'  I used as separator between instructions \ code and output examples!
There is no need to add these symbols to the file without comments. This single symbol is also a way to disable
certain commands and actions in the file!

###################################################################


19. nano docker-compose.yml   # open file for edit and input it:

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
              - ./nginx_serv/log/:/var/log/nginx/
        networks: 
            - main-server_docker-bridged

       
      
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
           - main-server_docker-bridged

     db: 
       image: mysql 
       command: --default-authentication-plugin=mysql_native_password 
       restart: always 
       ports:
         - '3306:3306'
       environment: 
          MYSQL_ROOT_PASSWORD: TestSkuljoba2024!
    
       networks:
          - main-server_docker-bridged 


     phpmyadmin: 
       image: phpmyadmin 
       restart: always 
       ports: 
         - 8080:80 
       environment: 
         - PMA_ARBITRARY=1

       networks:
          - main-server_docker-bridged

networks:
  main-server_docker-bridged:
     driver: bridge

###########################################################################

20. Save and close this file and run the next commands(21 \21.1) 
#Your current location before start first command should be in catalog'main-server' 
# Check it before start next commands!

21. cd nginx_serv && mkdir -p Backup app  nginx_conf log && touch Dockerfile && cd ..

21.1 cd nginx_serv/nginx_conf && mkdir -p conf.d && touch conf.d/default.conf && cd .. && cd ..

# check created subcatalogs in nginx_serv , run the command: 'ls-l nginx_serv/'
example output:

####################################################
total 12
drwxr-xr-x 2 root root 4096 Mar 30 14:20 app
drwxr-xr-x 2 root root 4096 Mar 30 14:20 Backup
-rw-r--r-- 1 root root    0 Mar 30 14:20 Dockerfile
drwxr-xr-x 2 root root 4096 Mar 30 14:20 nginx_conf
####################################################

22. Now our current catalog  '/home/vagrant/main-server#'     
# if you having another location now, go to catalog 'main-server' before input the next command(23):

23. cd php_fpm_serv/ && mkdir -p app && touch Dockerfile hello.php && cd .. 
# check created subcatalogs in php_fpm_serv, run the command: 'ls-l php_fpm_serv/'

example output:

#############################################
total 4
drwxr-xr-x 2 root root 4096 Mar 30 14:29 app
-rw-r--r-- 1 root root    0 Mar 30 14:29 Dockerfile
-rw-r--r-- 1 root root    0 Mar 30 14:29 hello.php

#############################################

24. check your current location in console, run: 'pwd' for check location.Next need start command from catalog 'main-server'
#if you have another location, need return to catalog  'main-server'.

Soon we will run the command for check docker networks! 
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

27.  docker network create --driver bridge main-server_docker-bridged
# after command you can check again commandand, you will see list networks run :'docker network ls'
!!!!!!!Notification! Also you can start file from root catalog 'main-server':  
./1.run_before_start_docker-compose.sh # it command add network bridge name to docker network!

# After that, needed bridge network willbe created! 
example output:

########################################################################
NETWORK ID     NAME                                    DRIVER    SCOPE
7684d5464b18   bridge                                  bridge    local
54e2e0a0791d   host                                    host      local
2111f054e742   main-server_docker-bridged              bridge    local
4a56da164e69   none                                    null      local

#########################################################################

As you see, bridge docker network('main-server_docker-bridged ') was added as bridge docker network,
and up. But later we need also add to this network our container names, that we already have in docker-compose.yml:
( container_name: nginxapp and container_name: php_fpm ) 
!!!Notification! We can add this names to network bridge only after first start docker containers with this names! 

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
after requests, and next block configuration will resolve requests ro our second container with php_fpm.
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
this system will be need for me as full system for advanced software, which
need local run on this server! 
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
EXPOSE 9000

#######################################

Save file and exit from editor.
 
 
34. Now we will start docker-compose.yml, that will be build our micro-services.
After start this services should be created and started four docker containers:
nginxapp ; php_fpm ; sql  ; phpmyadmin .

!!!Notification! Last two services(sql ; phpmyadmin) created and added to docker-compose.yml and started,
because later you will need working with sites, which will be have dynamical structure web resource.
For this sites perhaps will be need started database on your server and easy access to this database via web.
If you no need start this advanced containers, you can cut from docker-compose.yml next commands
and save your file! You can cut this blocks from docker-compose.yml and save it file 

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
          - main-server_docker-bridged


    phpmyadmin:
       image: phpmyadmin
       restart: always
       ports:
         - 8080:80
       environment:
         - PMA_ARBITRARY=1 

       networks:
          - main-server_docker-bridged 
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
you can go to catalogs which have Dockerfile (/main-server/nginx_serv/ ; /main-server/php_fpm_serv/)
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

docker build -t php_fpm .

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
        image: nginxapp             
        container_name: nginxapp
#       build:						                                  
#         context: ./nginx_serv/
        restart: always
        ports:
         - '80:80'
        volumes:
              - ./nginx_serv/nginx_conf/conf.d:/etc/nginx/conf.d
              - ./nginx_serv/app/:/var/www/html/
              - ./nginx_serv/log/:/var/log/nginx/
        networks:
            - main-server_docker-bridged

################################################################################################################

Save file and exit from editor.

Same operation you will need do, If you have the problem auto build docker image for php-fpm

Example 2- edit block php_fpm service:

################################################################################################################

     php_fpm:
       image: php_fpm
       container_name: php_fpm
#      build:
#        context: ./php_fpm_serv/
       restart: always
       ports:
         - '9000:9000'
       volumes:
          - ./php_fpm_serv/app/:/var/www/html/
#         - ./nginx_serv/app/:/var/www/html/
       networks:
           - main-server_docker-bridged

################################################################################################################
Save file and exit from editor.

Done troubleshooting block.
----------------------------------------------------------------------------------------------------------------
36. Now we need go back to our root project directory (/main-server)

37. docker-compose up -d  # Start docker-compose again

38 docker ps              # You should be see your started docker containers.

39. Next we need add our containers names to docker bridge network:

39.1 For add all name containers to bridge docker network  after first start docker-compose.yml  
need run next command:

docker network connect main-server_docker-bridged nginxapp

docker network connect main-server_docker-bridged php_fpm

docker network connect main-server_docker-bridged mysql

docker network connect main-server_docker-bridged phpmyadmin
 
#Also you can run script /main-server/2.run_after_start_docker-compose.sh
# This script will be run all this command, and after that will restart docker-compose for apply setting.

40.docker ps                    #this command show all your running containers:

41. Now we can check in browser our started resources
#As you remember I detected my ip address root test VM . it: 192.168.1.133
#We can use this address for example. But you need know your ip address test Vbox server or remote VM!

42. http://your_ip_address/            
#run it on the browser and you can see next output from docker microservice nginx(it request will be use port 80- http):

#####################################
Hello from nginx!

Test html nginx
#####################################

43. http://your_ip_address/index.php/
#run it on the browser and you can see next output from docker microservice php_fpm, request will be resolved from server nginx on same port!

#####################################
Hello from PhP_fpm!
#####################################  

44. http://your_ip_address:8080
#After ran this command you can see web ui phpmyadmin , and you can logon and will see all databases created in mysql docker container
for logon you can use login:root and password from docker-compose.yml in section 'db' 'MYSQL_ROOT_PASSWORD:'

-----------------------------------------------------------------------------------------------------------------------------------------------


Done.
