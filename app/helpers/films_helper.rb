module FilmsHelper

  def film_poster(film)
    if film.posters.blank?
      image_tag 'movie-placeholder.jpg', :class => 'poster placeholder'
    else
      image_tag film.posters['cover'], :class => 'poster'
    end
  end

  def classification(film)
    content_tag(:span, film.classification, :class => "certificate certificate-#{film.classification.downcase}") if film.classification.present?
  end

  def imdb_link(film)
    link_to "View #{film.title} on IMDB", "http://www.imdb.com/title/#{film.imdb_id}" if film.imdb_id
  end

  def tmdb_link(film)
    link_to "View #{film.title} on TMDB", film.tmdb_url if film.tmdb_url
  end

end
