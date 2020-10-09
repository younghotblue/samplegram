class AddHashbodyToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :hashbody, :string
  end
end
