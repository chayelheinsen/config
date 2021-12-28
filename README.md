Config is a tool to easily create configuration JSON for your apps.
You can create JSON files that your app can read from to configure certain things; say you need to enable maintenance mode, or change some text, or enable a feature; Config can help you do that quickly and easily without having to deploy new code.

# Getting Started

### Environment Variables

You should have these variables setup on your environment where this app will run:


### `REDIS_PROVIDER`

Set to the environment variable that contains the URL of your redis instance. For example, if running in docker, you may a variable called `DOCKER_REDIS`. The value of REDIS_PROVIDER would be DOCKER_REDIS. This allows you to change the redis provider on the fly quickly and allows you to keep multiple variables on your environment for all of your redis providers.

