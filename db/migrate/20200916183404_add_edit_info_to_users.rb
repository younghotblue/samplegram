class AddEditInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :website, :string
    add_column :users, :profile, :text
    add_column :users, :phone_number, :string
    add_column :users, :sex, :integer
  end
end
