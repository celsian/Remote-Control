class AddPriorityToRemoteControls < ActiveRecord::Migration[7.0]
  def change
    add_column :remote_controls, :priority, :string, :default => "1"
  end
end
