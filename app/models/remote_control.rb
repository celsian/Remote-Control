class RemoteControl < ActiveRecord::Base
  default_scope { order("name") }

  validates :gpio, presence: true, uniqueness: true
  validate :gpio_validation

  VALID_GPIO = ["4","17","18","21","22","23","24","25"]

  def gpio_validation
    gpios = ["4","17","18","21","22","23","24","25"]
    unless gpios.include?(gpio)
      errors.add(:base, 'value cannot be outside the valid GPIO Range.')
    end
  end

end
