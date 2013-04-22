require 'frappuccino/source'
require 'frappuccino/inject'

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

    def inject(start, &blk)
      Inject.new(self, start, &blk)
    end
  end
end
