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

  def home_link(film)
    link_to "View the official #{film.title} site", film.homepage_url if film.homepage_url
  end

  def youtube_embed(film)
    return if film.trailer_url.blank?
    id = film.trailer_url.split('=')[1]
    "<object width='425' height='344'><param name='movie' value='http://www.youtube.com/v/#{id}&amp;rel=0&amp;fs=1&amp;hd=1'></param><param name='allowFullScreen' value='true'></param><param name='allowscriptaccess' value='false'></param><embed src='http://www.youtube.com/v/#{id}&amp;rel=0&amp;fs=1&amp;hd=1' type='application/x-shockwave-flash' allowscriptaccess='false' allowfullscreen='true' width='425' height='344'></embed></object>".html_safe
  end

  def genres(film)
    return if film.genres.blank?
    film.genres.map { |genre| genre[0] }.join(', ')
  end

end
