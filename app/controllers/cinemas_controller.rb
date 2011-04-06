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
    if params[:cinema].present?
      @cinema = Cinema.find(params[:cinema][:cinema_id])
      redirect_to cinema_path(@cinema)
    end

    if request.xhr?
      if params[:lat].present? && params[:lng].present?
        @cinema = Cinema.geocoded.near([params[:lat].to_f, params[:lng].to_f], 100).first
        @todays_films = @cinema.films.for_today
        render :action => 'show', :layout => false
      end
    end
  end

end

