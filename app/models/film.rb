class Film < ActiveRecord::Base
  set_primary_key :edi

  serialize :posters
  serialize :backdrops

  # Relationships
  has_many :performances
  has_one :tmdb
  has_friendly_id :title, :use_slug => true

  # Validations
  validates_uniqueness_of :title
  validates_uniqueness_of :edi

  # Scopes
  default_scope order('title asc')
  scope :grouped, group('performances.film_id')
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
    posters, backdrops = {}, {}

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

    self.update_attributes(
      :imdb_id => film.imdb_id,
      :tmdb_url => film.url,
      :overview => film.overview,
      :release_date => film.released,
      :posters => posters,
      :backdrops => backdrops,
      :rating => film.attributes['rating'],
      :votes => film.attributes['votes'],
      :popularity => film.popularity
    )
  end

end


