class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.text :token_ciphertext
      t.bigint :user_id
      t.boolean :is_valid, default: true
      t.timestamps
    end
    add_column :api_keys, :token_bidx, :string
    add_index :api_keys, :token_bidx, unique: true

    add_index :api_keys, :user_id
  end
end
