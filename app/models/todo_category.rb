class TodoCategory < ApplicationRecord
  #belongs_to :todo
  belongs_to :category
  belongs_to :user
end
