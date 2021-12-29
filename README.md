Config is a tool to easily create configuration JSON for your apps.
You can create JSON files that your app can read from to configure certain things; say you need to enable maintenance mode, or change some text, or enable a feature; Config can help you do that quickly and easily without having to deploy new code.

# Getting Started

### Building the Docker Image

1. You should have Docker installed. You can [download it here](https://www.docker.com/get-started).
1. For development, make a `.env` file at the root of the project. More information on this can be found in the [Environment Variables](#environment-variables) section.
1. At the root of the project, run the following command to build the image: `$ docker compose build`
1. Create and migrate the database: 

    ```sh
    $ docker compose run --rm web bin/rails db:create
    $ docker compose run --rm web bin/rails db:migrate
    ```
1. Once that's done, you can run `$ docker compose up` to bring up the app. It should load onto localhost:3000

### Environment Variables

You should have these variables setup on your environment where this app will run. If running in development, there's a `.env.example` file that you should copy over to `.env` and fill in any missing variables.


### `REDIS_PROVIDER`

Set to the environment variable that contains the URL of your redis instance. For example, if running in docker, you may a variable called `DOCKER_REDIS`. The value of REDIS_PROVIDER would be DOCKER_REDIS. This allows you to change the redis provider on the fly quickly and allows you to keep multiple variables on your environment for all of your redis providers.

### `SIDEKIQ_AUTH_PASSWORD`

The password for the Sidekiq monitoring page.