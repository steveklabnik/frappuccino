module Frappuccino
  class Zip < Stream
    def initialize(left, right)
      @left_buffer = []
      @right_buffer = []
      left.add_observer(self, :left_update)
      right.add_observer(self, :right_update)
    end

    def left_update(event)
      if @right_buffer.length > 0
        occur([event, @right_buffer.shift])
      else
        @left_buffer << event
      end
    end

    def right_update(event)
      if @left_buffer.length > 0
        occur([@left_buffer.shift, event])
      else
        @right_buffer << event
      end
    end
  end
end
