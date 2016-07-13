FactoryGirl.define do
  sequence(:info) { |n| "The #{n} time the gate was opened." }

  factory :note do
    info
    remote_control_id "1"
    user_id "1"
  end
end