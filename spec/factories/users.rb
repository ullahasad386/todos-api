FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email 'asad@example.com'
    password 'password'
  end
end
