require 'rails_helper'

RSpec.describe TodoCategory, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  it { should belong_to(:todo)}
  it { should belong_to(:category)}
  
end