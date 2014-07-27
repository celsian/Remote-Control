class Note < ActiveRecord::Base
  default_scope order("id DESC")

  def self.add(current_user, remote_control)
    Note.check_count
    return Note.create(info: "#{current_user.email} triggered the #{remote_control.name}")
  end

  def self.head_add(current_user, remote_control)
    Note.check_count
    return Note.create(info: "#{current_user.email} triggered the #{remote_control.name} for head level.")
  end

  def self.check_count
    if Note.count > 99
      Note.last.destroy
      Note.check_count
    end
  end

end
