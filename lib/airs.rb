require 'airs/next_episode'
require 'airs/pushover'
require 'airs/watch_list'

module Airs
  class Main
    PUSHOVER_TOKEN = '2mFVOz9QhQKdUipmVnARrA38z6lfQv'

    def run(argf)
      list   = WatchList.new(argf)
      source = NextEpisode.new(list)

      if (airs = source.airs_today).any?
        pushover = Pushover.new(PUSHOVER_TOKEN)
        pushover.notify(user_key, "Airs today: #{airs.join(', ')}")
      end

    rescue => ex
      $stderr.puts "#{ex.message}"
      exit 1
    end

    private

    def user_key
      ENV.fetch('PUSHOVER_USER') { raise "PUSHOVER_USER not set" }
    end

  end
end
