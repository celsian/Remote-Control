class AddControllerToUsers < ActiveRecord::Migration[7.0]
  def self.up
    add_column :users, :controller, :boolean, :default => false
  end

  def self.down
    remove_column :users, :controller
  end
end
