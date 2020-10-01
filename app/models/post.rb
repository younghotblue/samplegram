class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :caption, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :image,   content_type: { in: %w[image/jpeg, image/png],
                                      message: "有効な画像形式である必要があります" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB未満である必要があります" }
                                      
  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [900, 900])
  end
  
  def liked_by(user)
    # user_idとpost_idが一致するlikeを検索する
    Like.find_by(user_id: user.id, post_id: id)
  end
end
