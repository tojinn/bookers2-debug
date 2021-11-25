class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @books = Book.new
    @booklist = Book.all
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all
    @books = Book.new
    @book = Book.all
    @user = current_user
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
  
  def follow
    user = user.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
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
