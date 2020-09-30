class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :image,   content_type: { in: %w[image/jpeg, image/png],
                                      message: "有効な画像形式である必要があります" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB未満である必要があります" }
                                      
  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [900, 900])
  end
end
