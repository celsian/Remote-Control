class AddRemoteControlRefToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :remote_control, index: true
  end
end
