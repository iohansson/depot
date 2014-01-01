FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "iohansson#{n}" }
    password "pass"
    password_confirmation "pass"
    
    factory :invalid_user do
      name nil
    end
  end
end
