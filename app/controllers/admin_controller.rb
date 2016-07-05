class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @note_count = Note::NOTE_COUNT
  end

  def notes
    if params[:q]
      @index = params[:q].to_i
    else
      @index = 0
    end

    @notes_per_page = (Note::NOTE_COUNT)/20 #Divides up all notes into 20 separate pages for display purposes.

    @notes = Note.all[@index..@index+(@notes_per_page-1)]
    @notes_page_count = (Note.all.count/(@notes_per_page.to_f)).ceil
    @max_index = @notes_page_count*@notes_per_page-@notes_per_page
    @time = Time.new
  end

  def access_control
    @remote_controls = RemoteControl.all
  end

  def access_control_enable
    remote_control = RemoteControl.find(params[:id])
    remote_control.enabled = true
    if remote_control.save
      redirect_to admin_access_control_path, flash: { success: "The #{remote_control.name} has been enabled." }
    else
      flash[:error] = "Error: There was a problem enabling the controller."
      render :access_control
    end
  end

  def access_control_disable
    remote_control = RemoteControl.find(params[:id])
    remote_control.enabled = false
    if remote_control.save
      redirect_to admin_access_control_path, flash: { success: "The #{remote_control.name} has been disabled." }
    else
      flash[:error] = "Error: There was a problem disabling the controller."
      render :access_control
    end
  end

  def user_editor
    if params[:q]
      if params[:q].blank?
        params[:q] = "@"
      end
      @users = User.search(params[:q])
    else
      @users = []
    end

    @controllers = User.where(controller: true, admin: false)
    @admins = User.where(admin: true)
    @rows = [@controllers.length, @admins.length].max
  end

  def stats
    @notes = Note.all
  end

  def add_admin
    user = User.find(params[:id])
    user.admin = true
    if user.save
      redirect_to admin_user_editor_path(q: params[:q]), flash: { success: "#{user.email} is now an Administrator." }
    else
      flash[:error] = "Error: There was a problem adding the rights."
      render :add_editor_admin
    end
  end

  def remove_admin
    user = User.find(params[:id])
    unless User::PROTECTED_USERS.include?(user.email)
      user.admin = false
      if user.save
        redirect_to admin_user_editor_path(q: params[:q]), flash: { success: "#{user.email} is no longer an Administrator." }
      else
        flash[:error] = "Error: There was a problem removing the rights."
        render :view_editor_admin
      end
    else
      redirect_to admin_user_editor_path(q: params[:q]), flash: { error: "That user's rights cannot be removed." }
    end
  end

  def add_controller
    user = User.find(params[:id])
    user.controller = true
    if user.save
      redirect_to admin_user_editor_path(q: params[:q]), flash: { success: "#{user.email} is now an Controller." }
    else
      flash[:error] = "Error: There was a problem adding the rights."
      render :add_editor_admin
    end
  end

  def remove_controller
    user = User.find(params[:id])
    user.controller = false
    if user.save
      redirect_to admin_user_editor_path(q: params[:q]), flash: { success: "#{user.email} is no longer an Controller." }
    else
      flash[:error] = "Error: There was a problem removing the rights."
      render :view_editor_admin
    end
  end

  private

  def require_admin
    unless current_user.admin == true
      redirect_to root_path, flash: { error: "You are not authorized to perform that action." }
    end
  end

end
