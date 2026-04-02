class CreatePostComments < ActiveRecord::Migration[8.1]
  def change
    create_table :post_comments do |t|
      t.references :post, null: false, foreign_key: true
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
