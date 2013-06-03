module Frppuccino
  class Take < Stream
    def initialize(source, n)
      @n = n
      @length = 0
      source.add_observer(self)
    end

    def update(value)
      if @length < @n
        occur(value)
        @length += 1
      end
    end
  end
end
