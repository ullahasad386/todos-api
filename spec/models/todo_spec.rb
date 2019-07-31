require 'rails_helper'

RSpec.describe Todo, type: :model do
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title)}
  #it { should validate_presence_of(:created_by)}
  it { should belong_to(:category)}
  #pending "add some examples to (or delete) #{__FILE__}"
end
