class RemoteControlsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_controller

  def index
    @remote_controls = RemoteControl.all
  end

  def open
    remote_control = RemoteControl.find(params[:id])

    if remote_control.enabled
      GpioOpenWorker.perform_async(remote_control.id)

      note = Note.add(current_user, remote_control)

      flash.now[:success] = "The <b>#{remote_control.name}</b> was triggered at #{note.created_at.strftime("%I:%M:%S %p on %m-%d-%Y")}."

      respond_to do |format|
        format.html { redirect_to remote_controls_path, flash: { success: "The <b>#{remote_control.name}</b> was triggered at #{note.created_at.strftime("%I:%M:%S %p on %m-%d-%Y")}." } }
        format.js 
      end

    else
      flash.now[:error] = "The <b>#{remote_control.name}</b> is currently disabled."

      respond_to do |format|
        format.html { redirect_to remote_controls_path, flash: { error: "The <b>#{remote_control.name}</b> is currently disabled." } }
        format.js 
      end
    end
  end

  def head_open
    remote_control = RemoteControl.find(params[:id])

    if remote_control.enabled
      GpioHeadOpenWorker.perform_async(remote_control.id)

      note = Note.head_add(current_user, remote_control)

      flash.now[:success] = "The <b>#{remote_control.name}</b> was triggered for head level at #{note.created_at.strftime("%I:%M:%S %p on %m-%d-%Y")}."

      respond_to do |format|
        format.html { redirect_to remote_controls_path, flash: { success: "The <b>#{remote_control.name}</b> was triggered for head level at #{note.created_at.strftime("%I:%M:%S %p on %m-%d-%Y")}." } }
        format.js 
      end

    else
      flash.now[:error] = "The <b>#{remote_control.name}</b> is currently disabled."

      respond_to do |format|
        format.html { redirect_to remote_controls_path, flash: { error: "The <b>#{remote_control.name}</b> is currently disabled." } }
        format.js 
      end
    end
  end

  private

  def require_controller
    unless current_user.controller == true
      redirect_to root_path, flash: { error: "You are not authorized to perform that action." }
    end
  end

end
