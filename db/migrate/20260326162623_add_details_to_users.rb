class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    
    add_column :users, :dob, :date
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end
end
