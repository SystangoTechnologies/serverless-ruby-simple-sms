module ApplicationHelper

  def remove_previous_subscriptions(topic)
    if topic.subscriptions.count > 0
      topic.subscriptions.each do |subscription|
        subscription.delete()
      end
    end
  end 
  
end
