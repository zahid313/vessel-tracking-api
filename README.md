# Setting up the project with Docker

## Prerequisites

    Docker and Docker-compose should be installed on your machine.
    You should have a basic understanding of how to use Docker and Docker-compose.

## Steps

1. Clone the project from the repository

        $ git clone https://github.com/zahid313/vessel-tracking-api.git

2. Navigate to the project directory

        $ cd vessel-tracking-api

3. Build the Docker images using the following command

        $ docker-compose build

4. Start the containers using the following command

        $ docker-compose up -d

5. Create the database

        $ docker-compose run web rake db:create

6. Run migrations

        $ docker-compose run web rake db:migrate

7. To stop the containers, use the following command

        $ docker-compose down    



## Additional Information

The **docker-compose.yml** file has the configurations for the following services.

1. web: The Vessel Tracking API
2. nginx: The web server
3. postgres: The database
4. pgadmin: Postgres Administration


* The web service uses the Dockerfile in the project root to build the image.
* The nginx service uses the nginx.conf file in the project root as the configuration file.
* You can access the application by visiting http://localhost in your browser.
* If you make any changes to the database, you should run the migrations using 

        $ docker-compose run web rake db:migrate

    

## Conclusion

This project is set up with Docker, which makes it easy to run the application in different environments. The above steps should help you in setting up the project on your machine. In case of any issues or if you have any questions, please feel free to reach out to the project maintainers.

Happy Development

:+1: :sparkles: :camel: :tada:
:rocket: :metal: :octocat: