class Blog < ApplicationRecord
  validates :content, presence: true
  validates :content,    length: { in: 1..20 }

  belongs_to :user
  validates :user_id, presence: true

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  belongs_to :user
  has_many :comments

  mount_uploader :image, ImageUploader
end
