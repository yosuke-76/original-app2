FactoryBot.define do
  factory :message do
    association :room
    association :user
    content  {'aaa'}
  end
end
