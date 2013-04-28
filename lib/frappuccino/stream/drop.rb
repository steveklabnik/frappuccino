module Frappuccino
  class Drop < Stream
    def initialize(source, n)
      source.add_observer(self)

      @count = 0
      @dropped = 0
      @n = n
    end

    def update(event)
      @dropped += 1

      if @dropped > @n
        occur(event)
      end
    end
  end
end
