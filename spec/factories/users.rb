FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email { "#{name.gsub(/ /, "_")}@email.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
