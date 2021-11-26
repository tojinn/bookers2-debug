class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followerd, class_name: "Relationship", foreign_key: "followerd_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followerd
  has_many :follower_user, through: :followerd, source: :follower
  
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def after_sign_in_path_for(resource)
    user_path(users.id)
  end
  
  def follow(user_id)
    follower.create(followerd_id: user_id)
  end
  
  def unfollow(user_id)
    follower.find_by(followerd_id: user_id).destroy
  end
  
  def following?(user)
    following_user.include?(@user)
  end
  
end

