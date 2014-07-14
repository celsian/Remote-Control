class CreateRemoteControls < ActiveRecord::Migration
  def change
    create_table :remote_controls do |t|
      t.string :gpio
      t.string :name

      t.timestamps
    end
  end
end
