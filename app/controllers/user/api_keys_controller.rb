class User::ApiKeysController < ApplicationController
  before_action :authenticate_user!
  before_action :require_controller

  def create
    ApiKey.create(user: current_user)

    redirect_to edit_user_registration_path, flash: { success: "API Key created." }
  end

  def update
    ApiKey.find_by(user: current_user).update_token

    redirect_to edit_user_registration_path, flash: { success: "API Key regenerated." }
  end

  def destroy
    ApiKey.find_by(user: current_user).destroy

    redirect_to edit_user_registration_path, flash: { success: "API Key deleted." }
  end

  private

  def require_controller
    unless current_user.controller == true
      redirect_to root_path, flash: { error: "You are not authorized to perform that action." }
    end
  end
end