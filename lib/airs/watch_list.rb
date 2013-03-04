module Airs
  class WatchList

    def <<(pattern)
      patterns << Regexp.new(/#{pattern}/i)
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
