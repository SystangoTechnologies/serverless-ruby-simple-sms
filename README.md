# Serverless SMS Service
This is a simple serverless application build over Jets framework of the ruby. The application illustrates how we can create a simple serverless sms service using jets framework.
## Requirements
* AWS CLI

## Setup

### Step 1 - Install AWS CLI
```sh
$ sudo apt install awscli
```

### Step 2 - Configure AWS CLI
```sh
$ aws configure
```
### Step 3 - Take clone of the repository

```ruby_on_rails
$ git clone https://gitlab.com/prateek-systango/serverless-sms-service.git
$ cd serverless-sms-service
$ bundle install
```
### Step 5 - Run Application

To start your the jets server locally, you need to run

```ruby_on_rails
$ jets s
```
Your Service must be running on http://localhost:8888.

To send a SMS, you can hit the following endpoint as a POST request.

```ruby_on_rails
$ curl -X POST \
  'http://localhost:8888/dev/send_sms?number=9838878787&message=hi%20User&topic=testtopic' \
  -H 'cache-control: no-cache'
```

The required parameters in the request are :
* **numbers** [array] : Array of numbers to whom message is to be sent.
* **message** [string] : Message that is to be sent in SMS.
* **topic** [string] : SNS topic name.

## Deployment
To deploy your application to AWS, you need to just run single command

```ruby_on_rails
$ jets deploy
```

Once the application is deployed you will get the API endpoint using which you can access Live API.
