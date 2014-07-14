class WelcomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user
      if current_user.controller
        redirect_to remote_controls_path
      end
    end
  end
end
