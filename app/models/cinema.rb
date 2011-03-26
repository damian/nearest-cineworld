class Cinema < ActiveRecord::Base
  # Relationships
  has_many :performances
  has_many :films, :through => :performances
  has_friendly_id :name, :use_slug => true

  # Validations
  validates_uniqueness_of :name, :address

  # Geocoder gem
  geocoded_by :geocode_address, :latitude => :lat, :longitude => :lng
  after_validation :geocode

  # Scopes
  default_scope order('name asc')

  # Instance methods
  def to_address
    [address.split(', ').join('<br />'), postcode, telephone].join('<br />').html_safe
  end

  def geocode_address
    [address, postcode].join(', ')
  end
end

