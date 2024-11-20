FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "User #{n}" }
    password { "password123" }
  end

  factory :category do
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { "A test product" }
    price { 100.00 }
    stock { 10 }
    featured { false }
    association :category

    trait :featured do
      featured { true }
    end
  end

  factory :cart do
    association :user
  end

  factory :cart_item do
    association :cart
    association :product
    quantity { 1 }
    unit_price { product.price }
  end

  factory :order do
    association :user
    total_price { 100.00 }
    state { 'California' }
    city { 'Los Angeles' }
    zip { '90001' }
    address { '123 Test St' }
    phone { '1234567890' }
    status { 'pending' }
  end

  factory :order_item do
    association :order
    association :product
    quantity { 1 }
    unit_price { 100.00 }
  end
end
