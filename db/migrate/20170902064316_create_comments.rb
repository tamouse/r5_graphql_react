class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :uuid, null: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :post, foreign_key: true
      t.text :body, null: false, default: ""

      t.timestamps
    end

    add_index :comments, :uuid, unique: true
  end
end
