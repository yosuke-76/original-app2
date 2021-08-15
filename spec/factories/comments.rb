FactoryBot.define do
  factory :comment do
    association :user
    association :article
    text {'aaa'}
  end
end
