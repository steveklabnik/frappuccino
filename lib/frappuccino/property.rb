module Frappuccino
  class Property
    def initialize(zero, stream)
      @value = zero
      stream.add_observer(self)
    end

    def now
      @value
    end

    def update(value)
      @value = value
    end

    def sample(stream)
      stream.map do
        self.now
      end
    end
  end
end
