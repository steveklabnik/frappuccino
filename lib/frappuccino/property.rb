module Frappuccino
  class Property
  end
end

require 'frappuccino/property/map_property'
require 'frappuccino/property/until_property'
require 'frappuccino/property/toggle_property'

module Frappuccino
  class Property
    def initialize(zero, stream = nil)
      @value = zero

      if stream
        stream.on_value do |value|
          @value = value
        end
      end
    end

    def now
      @value
    end

    def sample(stream)
      stream.map do
        self.now
      end
    end

    def until(stream, property)
      UntilProperty.new(self, stream, property)
    end

    def toggle(stream, property)
      ToggleProperty.new(self, stream, property)
    end

    def map(&blk)
      MapProperty.new(self, &blk)
    end

    def to_ary
      [now]
    end
  end
end
