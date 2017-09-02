class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :uuid, unique: true
  end
end
