class CreateProfileFields < ActiveRecord::Migration[8.1]
  def change
    create_table :profile_fields do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
