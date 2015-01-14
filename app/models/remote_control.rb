class RemoteControl < ActiveRecord::Base
  has_many :notes

  default_scope { order("name") }

  validates :gpio, presence: true, uniqueness: true
  validate :gpio_validation

  VALID_GPIO = ["4","17","18","21","22","23","24","25"]

  def gpio_validation
    unless VALID_GPIO.include?(gpio)
      errors.add(:base, 'value cannot be outside the valid GPIO Range.')
    end
  end

end
