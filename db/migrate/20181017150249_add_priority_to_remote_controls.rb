class AddPriorityToRemoteControls < ActiveRecord::Migration
  def change
    add_column :remote_controls, :priority, :string, :default => "1"
  end
end
