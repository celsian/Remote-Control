require "rails_helper"

RSpec.describe RemoteControl, :type => :model do
  let(:remote_control) { FactoryGirl.create(:remote_control) }
  let(:remote_controls) { RemoteControl.all }

  it "orders by name" do
    gate = FactoryGirl.create(:remote_control, gpio: "23", name: "Gate")
    garage = FactoryGirl.create(:remote_control, gpio: "22", name: "Garage")

    expect(remote_controls.index(gate)).to be > remote_controls.index(garage)
  end

  it "requires a gpio number" do
    expect(FactoryGirl.build(:remote_control, gpio: "")).not_to be_valid
  end

  it "requires a valid GPIO number (one that exists on the rpi)" do
    expect(FactoryGirl.build(:remote_control, gpio: "2")).not_to be_valid
  end

  it "requires a unique GPIO number" do
    remote_control
    expect(FactoryGirl.build(:remote_control, name: "other_name")).not_to be_valid
  end

  it "requires a unique name" do
    FactoryGirl.create(:remote_control)

    expect(FactoryGirl.build(:remote_control)).not_to be_valid
  end
end