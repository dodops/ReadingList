class GenresController < ApplicationController
  def show
    @genre = Genre.friendly.find(params[:genre])
    @books = @genre.books
  end
end
