FactoryBot.define do
  factory :order_shipping_address do
    postcode { '123-4567'}
    prefecture_id { 2 }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { '1234567890'}
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
