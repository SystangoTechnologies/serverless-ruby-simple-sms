# frozen_string_literal: true

Jets.application.routes.draw do
  root 'jets/public#show'
  post 'send_sms', to: 'sms#send_sms'
  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: http://rubyonjets.com/docs/assets-serving/
  any '*catchall', to: 'jets/public#show'
end
