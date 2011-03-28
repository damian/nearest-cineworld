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
    film = tmdb.search(title).first[0]
    posters, backdrops = {}, {}
    film.posters.each do |poster|
      posters[poster.image.size] = poster.image.url
    end 

    film.backdrops.each do |backdrop|
      backdrops[backdrop.image.size] = backdrop.image.url
    end
    self.update_attributes(
      :imdb_id => film.imdb_id,
      :tmdb_url => film.url,
      :overview => film.overview,
      :released => film.released,
      :posters => posters,
      :backdrops => backdrops,
      :rating => film.attributes['rating'],
      :votes => film.attributes['votes'],
      :popularity => film.popularity
    )
  end

end


