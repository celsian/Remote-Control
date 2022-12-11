require "rails_helper"

RSpec.describe RemoteControl, :type => :model do
  let(:remote_control) { FactoryBot.create(:remote_control) }
  let(:remote_controls) { RemoteControl.all }

  describe "default scope" do
    it "orders by name" do
      gate = FactoryBot.create(:remote_control, gpio: "23", name: "Gate")
      garage = FactoryBot.create(:remote_control, gpio: "22", name: "Garage")

      expect(remote_controls.index(gate)).to be > remote_controls.index(garage)
    end
  end

  describe "validates presence of GPIO Number" do
    it "requires a gpio number" do
      expect(FactoryBot.build(:remote_control, gpio: "")).not_to be_valid
    end
  end

  describe "validates valid gpio number" do
    it "requires a valid GPIO number (one that exists on the rpi & VALID_GPIO)" do
      expect(FactoryBot.build(:remote_control, gpio: "2")).not_to be_valid
    end
  end

  describe "validates uniqueness of GPIO Number" do
    it "requires a unique GPIO number" do
      FactoryBot.create(:remote_control, name: "4", gpio: 4)

      expect(FactoryBot.build(:remote_control, name: "4 again", gpio: 4)).not_to be_valid
    end
  end

  describe "validates uniqueness of name" do
    it "requires a unique name" do
      FactoryBot.create(:remote_control, name: "4")

      expect(FactoryBot.build(:remote_control, name: "4")).not_to be_valid
    end
  end
end