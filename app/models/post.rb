class Post < ApplicationRecord
  belongs_to :user
  has_many :hashtag_posts, dependent: :destroy
  has_many :hashtags, through: :hashtag_posts
  has_many :hashtag_posts, dependent: :destroy
  has_many :hashtags, through: :hashtag_posts
  has_many :notifications, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :caption, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/png],
                                      message: "有効な画像形式である必要があります" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB未満である必要があります" }
                                      
  # フィード用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [900, 900])
  end
  
  #プロフィールページ用のリサイズ済み画像を返す
  def image_gallery
    image.variant(resize_to_limit: [300, 300])
  end
  
  #投稿詳細ページ用のリサイズ済み画像を返す
  #投稿詳細ページ用のリサイズ済み画像を返す
  def show_image
    image.variant(resize_to_limit: [700, 800])
  end
  
  #ハッシュタグ
  def hashtag_image
    image.variant(resize_to_limit: [500, 500])
  end
  
  #ハッシュタグ
  def hashtag_image
    image.variant(resize_to_limit: [500, 500])
  end
  
  def liked_by(user)
    # user_idとpost_idが一致するlikeを検索する
    Like.find_by(user_id: user.id, post_id: id)
  end
  
  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
  
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
                                  current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      
      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = Comment.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
  after_create do
    post = Post.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    if post.hashbody?
      hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        # ハッシュタグは先頭の#を外した上で保存
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        post.hashtags << tag
      end
    end
  end
  
  #更新アクション
  before_update do
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
end

