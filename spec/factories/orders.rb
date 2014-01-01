FactoryGirl.define do
  factory :order do
    email "e@mail.com"
    address "my fucking address"
    name "iohansson"
    pay_type "Check"
    
    factory :invalid_order do
      email nil
    end
  end
end
