FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "product product#{n}" }
    price 29.99
    description "pretty cool product"
    locale "en"
  end
end
