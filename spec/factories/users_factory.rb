FactoryGirl.define do
  sequence(:email) { |n| "no-one-#{n}@example.com" }

  factory :user do
    email
    password "password"
    password_confirmation "password"
    controller false
    admin false
  end

  factory :controller, parent: :user do
    sequence(:email) { |n| "controller-#{n}@example.com" }
    controller true
  end

  factory :admin, parent: :user do
    sequence(:email) { |n| "admin-#{n}@example.com" }
    controller true
    admin true
  end
end