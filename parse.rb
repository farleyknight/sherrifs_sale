require 'nokogiri'
require 'yaml'
require 'active_record'
require 'open-uri'
require 'geocoder'


# TODO: Add ability to parse a table, given the Sheriff sale date.
def parse_table
  doc = Nokogiri::HTML(open("http://144.202.209.2/sheriff.salelisting/frameview.aspx"))
  doc.css('table tr').each do |row|
    property = {
      case_participants: row.children[2].inner_html,
      attorney:          row.children[3].inner_html,
      address:           row.children[4].inner_html,
      price:             row.children[5].inner_html
    }

    Property.create!(property) rescue nil
  end
end


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
