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

      puts "[+] Patterns: #{list.size}",
           "[+] Matched:  #{watching.size}/#{titles.size}"

      if watching.any?
        message = "Airs today: #{watching.join(', ')}"

        puts "[!] #{message}"

        Push.new(message).send!
      end

    rescue => ex
      $stderr.puts "#{ex.message}"
      exit 1
    end
  end
end
