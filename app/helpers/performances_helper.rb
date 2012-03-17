module PerformancesHelper

  def list_todays_performances(film, cinema)
    list_performances(film, cinema)
  end

  def list_tomorrows_performances(film, cinema)
    list_performances(film, cinema, :tomorrow)
  end

  def single_performance(performance)
    if performance.in_the_past?
      content_tag(:span, performance.time, :class => "performance unavailable")
    else
      link_to performance.booking_url do
        content_tag(:span, performance.time, :class => "performance available")
      end
    end
  end

  def list_performances(film, cinema, day = :today)
    times = []
    film.performances.for_cinema(cinema).send(day).each do |performance|
      times << single_performance(performance)
    end
    times.join.html_safe
  end

end
