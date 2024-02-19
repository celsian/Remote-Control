class ApiKey < ApplicationRecord
  belongs_to :user
  has_encrypted :token
  # blind_index :token, slow: true

  before_create :set_token

  # validates :token, uniqueness: true
  validates :user, uniqueness: true, presence: true

  def update_token
    self.token = secure_string
    self.save
  end

  private

  def set_token
    self.token = secure_string
  end

  def secure_string
    SecureRandom.hex
  end
end
