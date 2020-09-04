class User < ApplicationRecord
  before_save {self.email.downcase!}
  validates :name, presence:true, length: {maximum: 50}
  validates :email, presence:true, length: {maximum: 255},
                    format:{ with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: {case_sensitive: false}
  has_secure_password
  
  has_many :microposts
  
  has_many :relationships
  #自分がフォローしている複数user。ER図面の左側を自分自身と見たとき～
  
  has_many :followings, through: :relationships, source: :follow
  # through: :xxx source: :xxxで中間テーブルに設定しているカラムのデータを引っ張ってくる。
  #relationhipという中間テーブルの中から、follow_idを参照先のidとして取得している。followはuserがフォローしているユーザ
  
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"  #has_many :relationshipの逆方向
  #reverses～は自分で決めれる名前。 relationshipテーブルからデータ取得   follow_idのデータを。
  
  has_many :followers, through: :reverses_of_relationship, source: :user
  #revers_of_relationshipの中から、user_idを取得。
  #自分をフォローしているユーザを取得できる。
  
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  def follow(other_user) 
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
      #relationshipsテーブルから、follow_id: other_user.idが見つかれば取得、無ければ作成してくれる
    end
  end
  
  def unfollow(other_user) #フォローがあればアンフォローする。
    relationship = self.relationships.find_by(follow_id: other_user.id) 
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  # def favoriteing?(user)
  #   favorites.where(user_id: user.id).exists?
  # end
end

#userモデルにメソッドかけばいいの？リレーションしてるからおｋてこと？