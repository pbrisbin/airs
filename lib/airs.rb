require 'airs/next_episode'
require 'airs/push'
require 'airs/watch_list'

module Airs
  class Main
    def run(argf)
      list   = WatchList.new
      source = NextEpisode.new

      argf.lines { |line| list << line.strip }

      titles   = source.todays_titles
      watching = titles.select { |t| list.match?(t) }

      if watching.any?
        push = Push.new("Airs today: #{watching.join(', ')}")
        push.send!
      end

    rescue => ex
      $stderr.puts "#{ex.message}"
      exit 1
    end
  end
end
