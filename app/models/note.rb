class Note < ActiveRecord::Base
  belongs_to :remote_control
  belongs_to :user

  NOTE_COUNT = 500

  default_scope { order("updated_at DESC") }

  def self.add(current_user, remote_control, opts = {})
    Note.check_count

    recent_notes = Note.where("updated_at >= ?", 30.seconds.ago)

    recent_notes.each do |note|
      if note.user == current_user && note.remote_control == remote_control && note.remote_control.name == "Gate"
        note.updated_at = Time.now
        note.save
        return note
      end
    end

    info = "#{current_user.email} triggered the #{remote_control.name}"
    if opts[:api]
      info += " via API Key."
    end

    return Note.create(info: info, remote_control: remote_control, user: current_user)
  end

  def self.check_count
    if Note.count > (NOTE_COUNT)
      overflow = Note.all.offset((NOTE_COUNT))
      overflow.each { |note| note.destroy }
    end
  end

  def self.average_activations
    day_count_array = Note.unscoped.group_by_day(:created_at).count.to_a

    count_array = []

    day_count_array.each do |day_count|
      count_array << day_count[1]
    end

    count_array.sum/count_array.count.to_f
  end

end