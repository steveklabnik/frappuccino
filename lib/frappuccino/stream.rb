require 'frappuccino/source'
require 'frappuccino/inject'

module Frappuccino
  class Stream
    include Observable
    
    def initialize(*sources)
      sources.each do |source|
        source.extend(Frappuccino::Source).add_observer(self)
      end

      @callbacks = []
    end

    def update(event)
      occur(event)
    end

    def map(&blk)
      Map.new(self, &blk)
    end

    def map_stream(hsh)
      Map.new(self) do |event|
        if hsh.has_key?(event)
          hsh[event]
        else
          hsh[:default]
        end
      end
    end
    
    def inject(start, &blk)
      Inject.new(self, start, &blk)
    end

    def select(&blk)
      Select.new(self, &blk)
    end

    def on_value(&blk)
      @callbacks << blk
    end

    def self.merge(stream_one, stream_two)
      new(stream_one, stream_two)
    end
    
    protected
    
    def occur(value)
      @callbacks.each do |callback|
        callback.call(value)
      end

      changed
      notify_observers(value)
    end
  end
  
  private 
  
  class Map < Stream
    def initialize(source, &blk)
      @block = blk
      @callbacks = []
      source.add_observer(self)
    end

    def update(event)
      occur(@block.call(event))
    end
  end

  class Select < Stream
    def initialize(source, &blk)
      @block = blk
      @callbacks = []
      source.add_observer(self)
    end

    def update(event)
      if @block.call(event)
        occur(event)
      end
    end
  end
end
