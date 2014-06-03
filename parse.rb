require 'nokogiri'
require 'open-uri'
require 'database'

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
