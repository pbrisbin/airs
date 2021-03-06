module Airs
  class WatchList

    def initialize(io)
      io.each_line do |line|
        patterns << Regexp.new(/#{line.strip}/i)
      end
    end

    def match?(title)
      patterns.any? { |p| title =~ p }
    end

    private

    def patterns
      @patterns ||= []
    end

  end
end
