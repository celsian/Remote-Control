class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { order("email") }

  has_many :notes

  PROTECTED_USERS = ['celsian@gmail.com']

  def self.search query
    query = query.downcase
    where("email LIKE :query", query: "%#{query}%")
  end

  def self.all_notes_count
    user_counts = {}
    User.all.each do |user|
      if user.notes.count > 0
        user_counts[user.email] = (user.notes.count)
      end
    end
    user_counts
  end

end
