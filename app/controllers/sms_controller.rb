# frozen_string_literal: true

class SmsController < ApplicationController
  before_action :initialize_sns
  before_action :set_numbers
  before_action :set_message

  def send_sms
    attributes = { 'DefaultSMSType' => 'Transactional' }
    @sns.set_sms_attributes(attributes: attributes)
    @numbers.each do |number|
      @sns.publish(phone_number: number, message: @message)
    end
    render json: { message: 'SMS send successfully!' }, status: 201
  rescue Aws::SNS::Errors::ServiceError => e
    render json: { message: e }, status: 422
  end

  private

  def set_numbers
    if params[:receiverNumbers].present?
      @numbers = []
      params[:receiverNumbers].uniq.each do |number|
        parse_number = Phonelib.parse(number)
        @numbers << parse_number.international(false)
      end
    else
      render json: { message: 'Please provide phone number.' }, status: 400
    end
  end

  def set_message
    if params[:message].present?
      @message = params[:message]
    else
      render json: { message: 'Please provide message.' }, status: 400
    end
  end

  def initialize_sns
    @sns = Aws::SNS::Client.new
  end
end
