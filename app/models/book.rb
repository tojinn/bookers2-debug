class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
	
  def self.search(search, word)
	if search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match" 
      @book = Book.where(title: word)
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def self.search(search, word)
	if search == "forward_match"
      @book = Book.where("category LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("category LIKE?","%#{word}")
    elsif search == "perfect_match" 
      @book = Book.where(category: word)
    elsif search == "partial_match"
      @book = Book.where("category LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def self.books(category_word)
    if books
       @book = Book.where("category LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
end
