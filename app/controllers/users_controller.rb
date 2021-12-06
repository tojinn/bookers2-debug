class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :set_q, only: [:index, :search]

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @booklist = Book.new
    @books = Book.all
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @today_book =  @book.created_today
    @yesterday_book = @book.created_yesterday
    @this_week_book = @book.created_this_week
    @last_week_book = @book.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
    @books = Book.all
    @user = current_user
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def follows
   @user = User.find(params[:id])
   @following_users = @user.following_user
  end
  
  def followers
    @user = User.find(params[:id])
    @follower_users = @user.follower_user
  end
  
  def search
    @results = @q.result
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

  def set_q
    @q = User.ransack(params[:q])
  end