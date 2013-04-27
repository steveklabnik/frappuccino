module Frappuccino
  class Select < Stream
    def initialize(source, &blk)
      @block = blk
      source.add_observer(self)

      @count = 0
    end

    def update(event)
      if @block.call(event)
        occur(event)
      end
    end
  end
end
