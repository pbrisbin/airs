module Airs
  class WatchList

    def <<(pattern)
      patterns << Regexp.new(/#{pattern.strip}/i)
    end

    def match?(title)
      patterns.any? { |p| title =~ p }
    end

    def size
      patterns.size
    end

    private

    def patterns
      @patterns ||= []
    end

  end
end
