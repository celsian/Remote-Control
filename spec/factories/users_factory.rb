FactoryGirl.define do
  factory :user do
    email "standard@user.com"
    password "password"
    password_confirmation "password"
    controller false
    admin false
  end

  factory :controller, parent: :user do
    controller true
  end

  factory :admin, parent: :user do
    controller true
    admin true
  end
end