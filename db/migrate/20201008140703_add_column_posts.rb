class AddColumnPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :Posts, :hashbody, :string
  end
end
