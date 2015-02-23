class Note < ActiveRecord::Base
  belongs_to :remote_control
  belongs_to :user

  NOTE_COUNT = 500

  default_scope { order("updated_at DESC") }

  def self.add(current_user, remote_control)
    Note.check_count

    recent_notes = Note.where("updated_at >= ?", 30.seconds.ago)

    recent_notes.each do |note|
      if note.user == current_user && note.remote_control == remote_control
        note.updated_at = Time.now
        note.save
        return note
      end
    end

    return Note.create(info: "#{current_user.email} triggered the #{remote_control.name}", remote_control: remote_control, user: current_user)
  end

  def self.head_add(current_user, remote_control)
    Note.check_count
    return Note.create(info: "#{current_user.email} triggered the #{remote_control.name} for head level.", remote_control: remote_control, user: current_user)
  end

  def self.check_count
    if Note.count > (NOTE_COUNT-1)
      overflow = Note.all.offset((NOTE_COUNT-1))
      overflow.each { |note| note.destroy }
    end
  end

end