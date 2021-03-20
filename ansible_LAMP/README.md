1. Go to ansible-playbooks folder. Four roles are present:  
    * Run the play media_wiki.yml to setup the DB, LAMP setup and media_wiki packages
    * Role: DB_setup is for configuring the DB with package installation and required db name with credentials 
    * Role: LAMP is for setting up Linux, Apache webserver, PHP and Mariadb package installation 
    * Role: Media_wiki is for setting up the binaries for the media_wiki 
    * Role: selinux_disable is to disable the selinux for the linux machine 
        
2. Ansible-playbooks
    * Roles for launching the mediawiki website
    * media_wiki.yml playbook which calls all the sub tasks required. 
     
## Action items ##

# Copy your custom yaml configuration to the server, e.g. to /tmp/wiki.yml
# clone the repo
sudo yum -y install git

git clone https://github.com/navinsnn53/media_wiki.git

cd media_wiki

ansible-playbook media_wiki.yml --ask-vault-pass

## Media Wiki App installation Steps
Now, open  web browser and type the URL http://example.com. You will be redirected to the following page:

<img width="1116" alt="welcome_page" src="https://user-images.githubusercontent.com/46679699/97656524-aff96480-1a8d-11eb-8a2a-0dcb52067769.png">

Now, click on the set up the wiki button. You should see the following page:

<img width="1440" alt="Screenshot 2020-10-30 at 8 56 44 AM" src="https://user-images.githubusercontent.com/46679699/97656625-dddea900-1a8d-11eb-8fce-46491789b4e4.png">


Now, provide  database details and click on the Continue button. You should see the following page:

<img width="1440" alt="Screenshot 2020-10-30 at 8 41 19 AM" src="https://user-images.githubusercontent.com/46679699/97655844-ff3e9580-1a8b-11eb-9a32-d0106312d16e.png">

Now, open  web browser and type the URL of your instance. You should see MediaWiki site in the following image for successful db:

<img width="1440" alt="Screenshot 2020-10-30 at 9 06 35 AM" src="https://user-images.githubusercontent.com/46679699/97657194-42e6ce80-1a8f-11eb-8704-5d48ee9a48d1.png">






