require 'frappuccino/inject'

module Frappuccino
  class Map
    def initialize(source, &blk)
      @source = source
      @block = blk
    end

    def values
      @source.values.map(&@block)
    end

    def inject(start, &blk)
      Inject.new(self, start, &blk)
    end
  end
end
