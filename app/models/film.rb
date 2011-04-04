# == Schema Information
#
# Table name: films
#
#  id             :integer(4)      not null
#  edi            :integer(4)      primary key
#  title          :string(255)
#  poster_url     :string(255)
#  film_url       :string(255)
#  still_url      :string(255)
#  advisory       :string(255)
#  classification :string(255)
#  cached_slug    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  imdb_id        :string(255)
#  tmdb_url       :string(255)
#  overview       :text
#  posters        :text
#  backdrops      :text
#  release_date   :date
#  popularity     :integer(4)
#  votes          :integer(4)
#  rating         :float
#  cast           :text
#  genres         :text
#  trailer_url    :string(255)
#  homepage_url   :string(255)
#

class Film < ActiveRecord::Base
  set_primary_key :edi

  serialize :posters
  serialize :backdrops
  serialize :cast
  serialize :genres

  # Relationships
  has_many :performances
  has_one :tmdb
  has_friendly_id :title, :use_slug => true

  # Validations
  validates_uniqueness_of :title
  validates_uniqueness_of :edi

  # Scopes
  default_scope order('title asc')
  # Normally just group by films.edi, but heroku requires all attributes to be referenced
  scope :grouped, group('films.edi, films.id, films.title, films.poster_url, films.film_url, films.still_url, films.advisory, films.classification, films.cached_slug, films.created_at, films.updated_at, films.imdb_id, films.tmdb_url, films.overview, films.posters, films.backdrops, films.release_date, films.popularity, films.votes, films.rating')
  scope :performances_for_date, lambda { |date| where('performances.date = ?', date) }
  scope :today, performances_for_date(Date.today)
  scope :tomorrow, performances_for_date(Date.today + 1)
  scope :for_today, today.grouped
  scope :for_tomorrow, tomorrow.grouped

  # Callbacks
  after_create :store_tmdb_info

  def store_tmdb_info
    tmdb = TMDBParty::Base.new(Settings.tmdb_api_key)
    film_title = title.gsub(/(2|3)D \-? /, '').strip
    film = tmdb.search(film_title).first
    posters, backdrops, cast, genres = {}, {}, [], {}

    return if film.blank?

    poster = film.posters[0]
    backdrop = film.backdrops[0]

    unless poster.blank?
      poster.sizes.each do |size|
        posters[size.to_s] = poster.send("#{size}_url".to_sym)
      end
    end

    unless backdrop.blank?
      backdrop.sizes.each do |size|
        backdrops[size.to_s] = backdrop.send("#{size}_url".to_sym)
      end
    end

    unless film.actors.blank?
      film.actors.each do |member|
        cast << member.attributes
      end
    end

    unless film.genres.blank?
      film.genres.each do |genre|
        genres[genre.name] = genre.url
      end
    end

    self.update_attributes(
      :imdb_id => film.imdb_id,
      :tmdb_url => film.url,
      :overview => film.overview,
      :release_date => film.released,
      :posters => posters,
      :backdrops => backdrops,
      :cast => cast,
      :genres => genres,
      :rating => film.attributes['rating'],
      :votes => film.attributes['votes'],
      :popularity => film.popularity,
      :trailer_url => film.trailer,
      :homepage_url => film.homepage
    )
  end

end


