class AddRemoteControlRefToNotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :notes, :remote_control, index: true
  end
end
