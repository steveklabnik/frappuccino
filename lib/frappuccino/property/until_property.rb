module Frappuccino
  class UntilProperty
    def initialize(first, switcher, second)
      @first = first
      @second = second
      @current_prop = @first

      switcher.on_value do |value|
        @current_prop = @second
      end
    end

    def now
      @current_prop.now
    end
  end
end
