class BookCommentsController < ApplicationController
    
    def create
     book = Book.find(params[:book_id])
     comment
    end
    
    def destroy
    end
    
end
