module Frappuccino
  class Inject
    def initialize(source, start, &blk)
      @value = start
      @block = blk
      @on_value = nil
      source.add_observer(self)
    end
    
    def update(event)
      @value = @block.call(@value, event)
      @on_value.call(@value) if @on_value

      @value
    end

    def on_value(&blk)
      @on_value = blk
    end

    def to_i
      @value
    end
  end
end
