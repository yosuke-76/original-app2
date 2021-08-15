FactoryBot.define do
  factory :article do
    association :user
    store_name  {'aaaa'}
    text        {'aaaa'}
    address     {'aaaa'}

    after(:build) do |article|
      article.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
