# Simple flask app
## Storing and retrieving user information from a local database
## Design

### The application consists of two parts:

*  flask service for REST calls
*  mongoDB as the selected DB. User 'email' and 'id' are considered unique indexes for our database.
*  both services can be deployed using the provided docker-compose.yml file
*  in test_requests.sh there are some available curl requests to test the application with the desired result
*  the endpoints can be described:  
/saveUser  
/getUser/email/<email>  
/getUser/ip_address/<ip_address>


## Installation Instructions

In a linux based system(instructions apply to Ubuntu 18.04):  
*  Login as root:  
    $sudo -s

*  Donwload and install docker-ce:  
    $apt update  
    $apt install apt-transport-https ca-certificates curl software-properties-common  
    $curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  
    $add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"  
    $apt update  
    $apt install docker-ce  

*  Download and install docker-compose:  
    $curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  
    $chmod +x /usr/local/bin/docker-compose  

*  Run application:    
Run:   
    $cd simple_app/    
    $docker-compose up -d  
and:   
    $docker ps to verify that the services are running

Now you can access the restapi service in http://localhost:5000 and MongoDB localhost:27017


## Note

If you want to deploy restapi service only you can do the following:
*  setup enviromental variable MONGO_DB=your_mongo(by default localhost:27017)
*  setup enviromental variable MONGO_USERNAME=your_username(by default admin)
*  setup enviromental variable MONGO_PASSWORD=your_password(by default admin)
*  setup enviromental variable FLASK_APP=restapi
*  cd simple_app/
*  flask run --host=0.0.0.0
