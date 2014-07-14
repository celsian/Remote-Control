class AddControllerToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :controller, :boolean, :default => false
  end

  def self.down
    remove_column :users, :controller
  end
end
