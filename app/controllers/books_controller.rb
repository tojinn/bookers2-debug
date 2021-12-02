class BooksController < ApplicationController

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
  end

  def index
    @book = Book.all
    @user = current_user
    @books = Book.new
  end

  def create
    @user = current_user
    @books = Book.new(book_params)
    @books.user_id = current_user.id
    if @books.save
      redirect_to book_path(@books), notice: "You have created book successfully."
    else
      @book = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end