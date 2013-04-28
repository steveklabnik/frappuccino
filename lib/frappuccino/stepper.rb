module Frappuccino
  class Stepper
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
  end
end
