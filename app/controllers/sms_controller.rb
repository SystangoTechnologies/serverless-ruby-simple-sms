class SmsController < ApplicationController
  include ApplicationHelper

  before_action :initialize_sns
  before_action :create_topic
  before_action :set_number
  before_action :set_message

  def send_sms
    begin
      remove_previous_subscriptions(@topic)
      subscription = @topic.subscribe({protocol: 'sms', endpoint: @number})
      @topic.publish({ message: @message })
      render json: {success: true, message: "SMS send successfully!", status: 200}
    rescue Aws::SNS::Errors::ServiceError => error
      render json: {success: false, message: error, status: 200}
    end
  end

  private
  
    def create_topic
      if params[:topic].present? 
        @topic = @sns.create_topic(name: params[:topic])
      else
        render json: {success: false, message: "Please pass the topic value", status: 200}
      end
    end

    def set_number
      if params[:number].present? 
        number =Phonelib.parse(params[:number])
        @number = number.international(false)
      else
        render json: {success: false, message: "Please pass the phone number value", status: 200}
      end
    end

    def set_message
      if params[:message].present? 
        @message = params[:message]
      else
        render json: {success: false, message: "Please pass the message value", status: 200}
      end
    end

    def initialize_sns
      @sns = Aws::SNS::Resource.new()
    end
end
