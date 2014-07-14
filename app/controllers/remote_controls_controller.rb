class RemoteControlsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_controller

  require 'gpio.rb'

  def index
    @remote_controls = RemoteControl.all
  end

  def open
    time = Time.new
    remote_control = RemoteControl.find(params[:id])
    Gpio.new.trigger(remote_control.gpio, remote_control.name)
    redirect_to remote_controls_path, flash: { success: "The #{remote_control.name} has been <B>opened</B> at #{time.strftime("%H:%M:%S on %m-%d-%Y")}." }
  end

  private

  def require_controller
    unless current_user.controller == true
      redirect_to root_path, flash: { error: "You are not authorized to perform that action." }
    end
  end

end
