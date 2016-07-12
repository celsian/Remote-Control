FactoryGirl.define do
  factory :user do
    email "standard@new_user.com"
    password "password"
    password_confirmation "password"
    controller false
    admin false
  end

  factory :controller, parent: :user do
    email "controller@new_user.com"
    controller true
  end

  factory :admin, parent: :user do
    email "admin@new_user.com"
    controller true
    admin true
  end
end