class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :photos, [:user_id, :created_at]
  end
end
