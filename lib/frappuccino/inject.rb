module Frappuccino
  class Inject
    def initialize(source, start, &blk)
      @value = start
      @block = blk
      @source = source
      
      source.add_observer(self)
    end
    
    def update(event)
      @value = @block.call(@value, event)
    end

    def to_i
      @value
    end
  end
end
