module Frappuccino
  class Map < Stream
    def initialize(source, &blk)
      @block = blk
      source.add_observer(self)

      @count = 0
    end

    def update(event)
      occur(@block.call(event))
    end
  end
end
