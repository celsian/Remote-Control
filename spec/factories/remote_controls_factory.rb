FactoryBot.define do
  factory :remote_control do
    sequence(:gpio) { |n| RemoteControl::VALID_GPIO[n % 8] }
    sequence(:name) { |n| "Door #{n}" }
  end

  factory :remote_control_disabled, parent: :remote_control do
    enabled false
  end
end