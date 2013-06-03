module Frppuccino
  class Map < Stream
    def initialize(source, &blk)
      @block = blk
      source.add_observer(self)
    end

    def update(event)
      occur(@block.call(event))
    end
  end
end
