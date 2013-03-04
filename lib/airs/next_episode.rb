require 'net/http'
require 'nokogiri'

module Airs
  class NextEpisode
    URI = URI.parse('http://next-episode.net')
    HEADER = "Today's TV Episodes:"

    def todays_titles
      doc    = Nokogiri::HTML(content)
      header = doc.search('h5').detect { |e| e.inner_text == HEADER }
      span   = header.parent.children.last
      span.search('a').map(&:inner_text)
    end

    private

    def content
      @content ||= Net::HTTP.get(URI)
    end
  end
end
