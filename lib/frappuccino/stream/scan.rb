module Frappuccino
  class Scan < Stream
    def initialize(source, zero, &blk)
      @last = zero
      @block = blk

      source.add_observer(self)

      @count = 0
    end

    def update(value)
      @last = @block.call(@last, value)
      occur(@last)
    end
  end
end
