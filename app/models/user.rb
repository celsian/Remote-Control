class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { order("email") }

  PROTECTED_USERS = ['celsian@gmail.com']

  def self.search query
    query = query.downcase
    where("email LIKE :query", query: "%#{query}%")
  end

end
