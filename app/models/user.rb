class User < ApplicationRecord
  has_secure_password

  #has_many :todos, foreign_key: :created_by


  has_many :todo_categories
  has_many :categories, through: :todo_categories


  validates_presence_of :name, :email, :password_digest
  #validates_uniqueness_of :email, :case_sensitive => false


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

end
