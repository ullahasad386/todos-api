class Category < ApplicationRecord

  has_many :todos, dependent: :destroy

  validates_presence_of :name
  validates_length_of :name, minimum: 3, maximum: 100
  validates_uniqueness_of :name

  has_many :todo_categories
  has_many :users, through: :todo_categories

end
