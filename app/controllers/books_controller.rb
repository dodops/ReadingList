class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe]
  before_action :authenticate_user!, except: [:index, :search]

  def index
    if params[:genre]
      @books = Book.genre_filter(params[:genre])
    else
      @books = Book.all 
    end
  end

  def search
    @books = Book.search(params[:search][:keyword])
    render 'index'
  end

  def user_list
    @books = current_user.books
    @redead_books = @books.finished
    @unread = @books.unfinished
  end

  def subscribe
    current_user.subscribe(@book)
    respond_to do |f|
      f.js
    end
  end

  def unsubscribe
    current_user.unsubscribe(@book)
    respond_to do |f|
      f.js
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
        format.js
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :description,
       :amazon_id, :rating,{ genre_ids: []})
    end
end
