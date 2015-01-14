class Note < ActiveRecord::Base
  belongs_to :remote_control

  default_scope { order("id DESC") }

  def self.add(current_user, remote_control)
    Note.check_count
    return Note.create(info: "#{current_user.email} triggered the #{remote_control.name}", remote_control: remote_control)
  end

  def self.head_add(current_user, remote_control)
    Note.check_count
    return Note.create(info: "#{current_user.email} triggered the #{remote_control.name} for head level.", remote_control: remote_control)
  end

  def self.check_count
    if Note.count > 99
      overflow = Note.all.offset(99)
      overflow.each { |note| note.destroy }
    end
  end

end
