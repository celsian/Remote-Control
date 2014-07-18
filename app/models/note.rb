class Note < ActiveRecord::Base
  def self.add(current_user, remote_control, time)
    Note.check_count
    Note.create(info: "#{current_user.email} opened the #{remote_control.name} at #{time.strftime("%H:%M:%S on %m-%d-%Y")}.")
  end

  def self.check_count
    if Note.count > 100
      Note.last.destroy
      Note.check_count
    end
  end

end
