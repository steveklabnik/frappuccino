module Frappuccino
  class MapProperty < Property
    def initialize(property, &block)
      @property = property
      @block = block
    end

    def now
      @block.call(@property.now)
    end
  end
end
