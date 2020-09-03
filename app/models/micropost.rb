class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
