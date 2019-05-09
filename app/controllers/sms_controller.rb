class SmsController < ApplicationController
  include ApplicationHelper

  before_action :initialize_sns
  before_action :set_numbers
  before_action :set_message

  def send_sms
    begin
      topic = create_topic(@sns)
      remove_previous_subscriptions(topic)
      @numbers.each do |number|
        topic.subscribe({protocol: 'sms', endpoint: number})
      end
      topic.publish({ message: @message })
      render json: {message: "SMS send successfully!"}, status: 201
    rescue Aws::SNS::Errors::ServiceError => error
      render json: {message: error}, status: 422
    end
  end

  private
    def set_numbers
      if params[:numbers].present? 
        @numbers = []
        params[:numbers].uniq.each do |number|
          parse_number =Phonelib.parse(number)
          @numbers << parse_number.international(false)
        end
      else
        render json: {message: "Please pass the phone number value"}, status: 400
      end
    end

    def set_message
      if params[:message].present? 
        @message = params[:message]
      else
        render json: {message: "Please pass the message value"}, status: 400
      end
    end

    def initialize_sns
      @sns = Aws::SNS::Resource.new()
    end
end
