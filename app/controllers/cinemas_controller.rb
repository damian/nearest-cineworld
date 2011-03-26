class CinemasController < ApplicationController
  respond_to :html

  def index
    @cinemas = Cinema.all
  end

  def show
    @cinema = Cinema.find(params[:id])
    @todays_films = @cinema.films.today.grouped
    @tomorrows_films = @cinema.films.tomorrow.grouped
  end

  def search
    @cinemas = Cinema.geocoded.near(params[:lat], params[:lng]) unless params[:lat].blank? && params[:lng].blank?
  end
end
