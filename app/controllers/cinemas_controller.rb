class CinemasController < ApplicationController
  respond_to :html

  def index
    @cinemas = Cinema.all
  end

  def show
    @cinema = Cinema.find(params[:id])
    @todays_films = @cinema.films.for_today
  end

  def search
    @cinema = Cinema.geocoded.near([params[:lat].to_f, params[:lng].to_f], 100).first unless params[:lat].blank? && params[:lng].blank?
    if request.xhr? && @cinema.present?
      @todays_films = @cinema.films.for_today
      render :action => 'show', :layout => false
    end
  end
end

