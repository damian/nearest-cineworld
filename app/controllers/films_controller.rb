class FilmsController < ApplicationController
  respond_to :html

  def index
    @films = Film.all
    respond_with @films
  end

  def show
    @film = Film.find(params[:id])
    respond_with @film
  end
end
