FactoryGirl.define do
  sequence(:email) { |n| "person-#{n}@example.com" }

  factory :user do
    email
    password "password"
    password_confirmation "password"
    controller false
    admin false
  end

  factory :controller, parent: :user do
    email
    controller true
  end

  factory :admin, parent: :user do
    email
    controller true
    admin true
  end
end