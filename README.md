# Serverless SMS Service
This is a simple serverless application build over Jets framework of the ruby. The application illustrates how we can create a simple serverless sms service using jets framework.
## Requirements
* RVM
* Ruby(2.5.1)
* AWS CLI
## Setup

### Step 1 - Install RVM
* Follow the steps given here: https://rvm.io/rvm/install, to install RVM in your machines

### Step 2 - Install Ruby
To install ruby(2.5.1) in your machine, run following command
```sh
$ rvm install ruby-2.5.1
```
### Step 3 - Install & Configure AWS
```sh
$ sudo apt install awscli
$ aws configure
```
### Step 4 - Take clone of the repository

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
  http://localhost:8888/send_sms \
  -H 'Authorization: {YOUR AUTHORIZATION KEY}' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{"numbers": ["91XXXXXXXX", "91XXXXXXXX"],"message": "HI"}'
```

The required parameters in the request are :
* **numbers** [array] : Array of numbers to whom message is to be sent.
* **message** [string] : Message that is to be sent in SMS.

## Deployment
To deploy your application to AWS, you need to just run single command

```ruby_on_rails
$ jets deploy production
```

Once the application is deployed you will get the API endpoint using which you can access Live API.

## Security

Once API gateway is created, you must setup Usage plan along with their API Keys form API gateway console. For this, you can follow the [official doc](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-setup-api-key-with-console.html) for the same given by AWS.

If you want a custom authorization instead of this, just comment out the **before_filter:authorize** line in application.rb to make custom authorization work.