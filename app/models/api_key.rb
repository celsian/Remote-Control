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

  def self.find_token(token)
    ApiKey.all.each do |key|
      if key.token == token
        return key
      end
    end

    return nil
  end

  private

  def set_token
    self.token = secure_string
  end

  def secure_string
    SecureRandom.hex
  end
end
