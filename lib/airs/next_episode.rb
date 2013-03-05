require 'net/http'
require 'nokogiri'

module Airs
  class NextEpisode
    URL    = 'http://next-episode.net'
    HEADER = "Today's TV Episodes:"

    def todays_titles
      content = Net::HTTP.get(URI.parse(URL))

      Nokogiri::HTML(content)
        .search('h5').detect { |e| e.inner_text == HEADER }
        .parent.children.last
        .search('a').map(&:inner_text).uniq
    rescue
      raise "Error accessing or parsing next-episode.com"
    end

  end
end
