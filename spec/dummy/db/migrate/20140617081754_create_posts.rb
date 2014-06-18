class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.timestamp :published_at
      t.timestamp :unpublished_at

      t.timestamps
    end
  end
end
