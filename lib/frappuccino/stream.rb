require 'frappuccino/source'
require 'frappuccino/map'

module Frappuccino
  class Stream
    attr_reader :values

    def initialize(source)
      @source = source.extend(Frappuccino::Source)
      @source.add_observer(self)
      @values = []
    end

    def update(event)
      @values << event
    end

    def map(&blk)
      Map.new(self, &blk)
    end
  end
end
