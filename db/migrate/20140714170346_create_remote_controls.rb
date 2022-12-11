class CreateRemoteControls < ActiveRecord::Migration[7.0]
  def change
    create_table :remote_controls do |t|
      t.string :gpio
      t.string :name

      t.timestamps
    end
  end
end
