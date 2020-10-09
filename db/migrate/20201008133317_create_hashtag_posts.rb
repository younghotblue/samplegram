class CreateHashtagPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtag_posts do |t|
      t.references :post, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true
    end
  end
end
