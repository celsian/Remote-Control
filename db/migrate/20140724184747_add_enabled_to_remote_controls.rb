class AddEnabledToRemoteControls < ActiveRecord::Migration[7.0]
  def self.up
    add_column :remote_controls, :enabled, :boolean, :default => true
  end

  def self.down
    remove_column :remote_controls, :enabled
  end
end
