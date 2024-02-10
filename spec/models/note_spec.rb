require "rails_helper"

RSpec.describe Note, type: :model do
  let(:user) { create(:user) }

  describe "add" do
    let(:remote_control) { create(:remote_control, name: "Gate") }

    context "gate not triggered in the last 30 seconds" do
      it "adds a note" do
        note = Note.add(user, remote_control)

        expect(Note.last).to eq(note)
      end
    end

    context "gate triggered last 30 seconds" do
      it "updates previous note" do
        Note.create(user: user, remote_control: remote_control, info: "#{user.email} triggered the #{remote_control.name}.", created_at: 10.seconds.ago, updated_at: 10.seconds.ago)
        note2 = Note.add(user, remote_control)

        expect(note2.created_at).to_not eq(note2.updated_at)
      end
    end
  end

  describe "check_count" do
    let!(:notes) { create_list(:note, 505) }

    it "destroys oldest note over NOTE_COUNT limit" do
      Note.check_count

      expect(Note.count).to eq(Note::NOTE_COUNT)
    end
  end

  describe "average_activations" do
    let(:remote_control) { create(:remote_control) }
    let!(:notes1) { create_list(:note, 5, created_at: 2.days.ago) }
    let!(:notes2) { create_list(:note, 5, created_at: 1.days.ago) }
    let!(:notes3) { create_list(:note, 15) }

    it "returns the average activations per day for last 500 notes" do
      expect(Note.average_activations).to eq((5+5+15)/(3.to_f))
    end
  end
end