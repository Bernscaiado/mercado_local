class AddBrandToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :brand, :string
  end
end
