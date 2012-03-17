# == Schema Information
#
# Table name: cinemas
#
#  id          :integer(4)      not null
#  cinema_id   :integer(4)      primary key
#  name        :string(255)
#  cinema_url  :string(255)
#  address     :text
#  postcode    :string(255)
#  telephone   :string(255)
#  lat         :float
#  lng         :float
#  cached_slug :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Cinema < ActiveRecord::Base
  set_primary_key :cinema_id

  # Relationships
  has_many :performances
  has_many :films, :through => :performances, :uniq => true
  has_friendly_id :name, :use_slug => true

  # Validations
  validates_uniqueness_of :name, :address

  # Geocoder gem
  geocoded_by :geocode_address, :latitude => :lat, :longitude => :lng
  after_validation(:on_create) do
    :geocode
  end

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

