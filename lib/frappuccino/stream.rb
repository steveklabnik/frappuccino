require 'frappuccino/source'
require 'frappuccino/inject'

module Frappuccino
  class Stream
    include Observable
    
    def initialize(sources)
      sources = Array(sources)

      sources.each do |source|
        source.extend(Frappuccino::Source).add_observer(self)
      end

      @on_value = nil
    end

    def update(event)
      @on_value.call if @on_value

      changed
      notify_observers(event)
    end

    def map(&blk)
      Map.new(self, &blk)
    end
    
    def inject(start, &blk)
      Inject.new(self, start, &blk)
    end

    def on_value(&blk)
      @on_value = blk
    end

    def self.merge(stream_one, stream_two)
      new([stream_one, stream_two])
    end
  end
  
  private 
  
  class Map < Stream
    def initialize(source, &blk)
      @block = blk
      source.add_observer(self)
    end

    def update(event)
      changed
      notify_observers(@block.call(event))
    end
  end
end
