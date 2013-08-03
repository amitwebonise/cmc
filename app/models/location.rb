class Location < ActiveRecord::Base
  belongs_to :activity#, :polymorphic => true
  attr_accessible :city, :country, :latitude, :longitude, :state, :street_address, :activity_id, :postal_code



  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city    = geo.state
      obj.state = geo.region rescue nil#long_name
      obj.country = geo.country

      #obj.street_address = geo.full_address
    end
  end
  after_validation :reverse_geocode

  def full_street_address
    return [street_address.to_s,city.to_s,state.to_s,postal_code.to_s,country.to_s].compact.join(', ')
  end
end
