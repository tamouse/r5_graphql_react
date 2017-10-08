class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :uuid, null: false
      t.belongs_to :user, foreign_key: true
      t.string :title, null: false, default: ""
      t.text :body, null: false, default: ""
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :uuid, unique: true
  end
end
