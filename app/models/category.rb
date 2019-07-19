class Category < ApplicationRecord
  has_many :todo_categories
  has_many :todos, through: :todo_categories 
  validates_presence_of :name
  validates_length_of :name, minimum: 3, maximum: 25
  validates_uniqueness_of :name
end
