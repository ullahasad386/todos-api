require 'rails_helper'

RSpec.describe Category, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name)}
  it { should validate_length_of(:name).is_at_least(3)}
  it { should have_many(:todos)}
end
