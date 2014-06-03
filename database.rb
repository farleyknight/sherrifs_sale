require 'yaml'
require 'active_record'
require 'geocoder'


dbconfig = YAML::load(File.open('database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)


class Property < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord

  validates :case_participants, :attorney, :address, :price, presence: true
  validates :address, uniqueness: true

  geocoded_by :geocodable_address
  after_validation :geocode

  def geocodable_address
    lines = address.split("<br>")
    if lines[1] =~ /PHILA/
      [lines[0], lines[1]].join(", ")
    elsif lines[2] =~ /PHILA/
      [lines[0], lines[2]].join(", ")
    end
  end
end
