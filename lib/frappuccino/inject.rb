module Frappuccino
  class Inject
    def initialize(source, start, &blk)
      @value = start
      @block = blk
      @callbacks = []
      source.add_observer(self)
    end

    def update(event)
      @value = @block.call(@value, event)
      @callbacks.each do |callback|
        callback.call(@value)
      end

      @value
    end

    def on_value(&blk)
      @callbacks << blk
    end

    def to_i
      @value
    end
  end
end
