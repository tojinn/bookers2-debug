class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followerd, class_name: "Relationship", foreign_key: "followerd_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followerd
  has_many :follower_user, through: :followerd, source: :follower
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  
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
  
  def following?(other_user)
    following_user.include?(other_user)
  end
  
  def self.search(search,word)
    if search == "forward_match"
     @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
     @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
     @user = User.where("#{word}")
    elsif search == "partial_match"
     @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end

