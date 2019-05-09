class ApplicationController < Jets::Controller::Base
  include ApplicationHelper
  before_action :authorize

  private
  def authorize
    authorization_key = get_authorization_key(request.headers['authorization'])
    if authorization_key != "#{ENV['API_CLIENT_ID']}:#{ENV['API_CLIENT_SECRET']}"
      render json: {message: "Unauthorized"}, status: 401
    end
  end
end
