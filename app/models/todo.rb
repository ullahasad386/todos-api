class Todo < ApplicationRecord

  belongs_to :category
  has_many :items, dependent: :destroy
  validates_presence_of :title
  #validates_presence_of :created_by

  before_validation(on: :create) do
    self.created_by = 'You'
  end

end
