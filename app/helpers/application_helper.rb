require 'base64'
require 'securerandom'



module ApplicationHelper

  def remove_previous_subscriptions(topic)
    if topic.subscriptions.count > 0
      topic.subscriptions.each do |subscription|
        subscription.delete()
      end
    end
  end 
  
  def get_authorization_key(authorization)
    Base64.decode64(authorization) rescue false
  end

  def create_topic(sns)
    sns.create_topic({name: SecureRandom.hex(5)})
  end

end
