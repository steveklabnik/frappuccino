module Frappuccino
  class ToggleProperty < Property
    def initialize(first, switcher, second)
      @properties = [first, second]
      @current_index = 0

      switcher.on_value do
        @current_index = (@current_index + 1) % 2
      end
    end

    def now
      @properties[@current_index].now
    end
  end
end
