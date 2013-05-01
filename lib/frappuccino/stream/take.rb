module Frappuccino
  class Take < Stream
    def initialize(source, n)
      @n = n
      @length = 0
      source.add_observer(self)
    end

    def update(value)
      occur(value) if @length < @n
      @length += 1
    end
  end
end
