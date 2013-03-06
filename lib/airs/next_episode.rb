require 'net/http'
require 'nokogiri'

module Airs
  class NextEpisode
    URL    = 'http://next-episode.net'
    HEADER = "Today's TV Episodes:"

    def initialize(watchlist)
      @watchlist = watchlist
    end

    def airs_today
      content = Net::HTTP.get(URI.parse(URL))

      Nokogiri::HTML(content)
        .search('h5')
        .detect { |e| e.inner_text == HEADER }
        .parent.children.last
        .search('a').map(&:inner_text).uniq
        .select { |t| watchlist.match?(t) }

    rescue => ex
      $stderr.puts "Error accessing or parsing next-episode.net"
      raise ex
    end

    private

    attr_reader :watchlist

  end
end
