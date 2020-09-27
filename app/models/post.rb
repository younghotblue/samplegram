class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  accepts_nested_attributes_for :photos
end
