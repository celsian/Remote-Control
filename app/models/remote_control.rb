class RemoteControl < ActiveRecord::Base
  has_many :notes

  default_scope { order("priority") }

  validates :name, presence: true, uniqueness: true
  validates :gpio, presence: true, uniqueness: true
  validates :priority, presence: true
  validate :gpio_validation

  VALID_GPIO = ["4","17","18","21","22","23","24","25"]

  def gpio_validation
    unless VALID_GPIO.include?(gpio)
      errors.add(:base, "Gpio value can't be outside the valid range: (#{VALID_GPIO.join(', ')})")
    end
  end

  def self.all_notes_count
    remote_control_counts = {}
    RemoteControl.all.each do |remote_control|
      if remote_control.notes.count > 0
        remote_control_counts[remote_control.name] = (remote_control.notes.count)
      end
    end
    remote_control_counts
  end

  def error_messages
    messages = ""
    errors.full_messages.each do |message|
      messages += message + ". "
    end
    messages
  end

end
