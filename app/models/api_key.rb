class ApiKey < ApplicationRecord
  belongs_to :user
  has_encrypted :token
  # blind_index :token, slow: true
  blind_index :token

  before_create :set_token

  validates :token, uniqueness: true
  validates :user, uniqueness: true, presence: true

  def update_token
    self.token = secure_string
    self.save
  end

  def self.get_tokens
    ApiKey.find_by(token: "6cb6a9efbaec802cbe2ad6f6a72ad176").id
  end

  private

  def set_token
    self.token = secure_string
  end

  def secure_string
    SecureRandom.hex
  end
end
