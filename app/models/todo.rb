class Todo < ApplicationRecord
  has_many :todo_categories
  has_many :categories, through: :todo_categories
  has_many :items, dependent: :destroy
  validates_presence_of :title, :created_by

end
