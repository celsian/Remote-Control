class Api::V1::BaseController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    authenticate_user_with_token || handle_bad_authentication
  end

  def authenticate_user_with_token
    authenticate_with_http_token do |token, options|
      @user ||= ApiKey.find_by(token: token).user
    end
  end

  def handle_bad_authentication
    render json: { message: "Bad credentials" }, status: :unauthorized
  end
end