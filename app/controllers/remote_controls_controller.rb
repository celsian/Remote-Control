class RemoteControlsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_controller
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy]

  def index
    @remote_controls = RemoteControl.all
  end

  def open
    remote_control = RemoteControl.find(params[:id])

    if remote_control.enabled
      GpioOpenWorker.perform_async(remote_control.id)

      note = Note.add(current_user, remote_control)

      flash.now[:success] = "The <b>#{remote_control.name}</b> was triggered at #{note.updated_at.strftime("%I:%M:%S %p on %m-%d-%Y")}."

      respond_to do |format|
        format.html { redirect_to remote_controls_path, flash: { success: "The <b>#{remote_control.name}</b> was triggered at #{note.updated_at.strftime("%I:%M:%S %p on %m-%d-%Y")}." } }
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

      flash.now[:success] = "The <b>#{remote_control.name}</b> was triggered for head level at #{note.updated_at.strftime("%I:%M:%S %p on %m-%d-%Y")}."

      respond_to do |format|
        format.html { redirect_to remote_controls_path, flash: { success: "The <b>#{remote_control.name}</b> was triggered for head level at #{note.updated_at.strftime("%I:%M:%S %p on %m-%d-%Y")}." } }
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

  def new
    @remote_control = RemoteControl.new
  end

  def edit
    @remote_control = RemoteControl.find(params[:id])
  end

  def create
    @remote_control = RemoteControl.new remote_control_params

    if @remote_control.save
      redirect_to admin_access_control_path, flash: { success: "GPIO entry added." }
    else
      flash[:error] = "Error: #{@remote_control.error_messages}"
      render :new
    end
  end

  def update
    @remote_control = RemoteControl.find(params[:id])

    if @remote_control.update(remote_control_params)
      redirect_to admin_access_control_path, flash: { success: "GPIO entry updated." }
    else
      flash[:error] = "Error: #{@remote_control.error_messages}"
      render :edit
    end
  end

  def destroy
    RemoteControl.find(params[:id]).destroy

    redirect_to admin_access_control_path, flash: { success: "GPIO entry deleted." }
  end

  private

  def remote_control_params
    params.require(:remote_control).permit(:id, :gpio, :name, :priority)
  end

  def require_controller
    unless current_user.controller == true
      redirect_to root_path, flash: { error: "You are not authorized to perform that action." }
    end
  end

  def require_admin
    unless current_user.admin == true
      redirect_to root_path, flash: { error: "You are not authorized to perform that action." }
    end
  end

end
