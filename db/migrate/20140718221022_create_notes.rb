class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :info

      t.timestamps
    end
  end
end
