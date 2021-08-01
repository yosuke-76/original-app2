FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.unique.free_email}
    password              {'aaaaa1'}
    password_confirmation {password}
  end
end