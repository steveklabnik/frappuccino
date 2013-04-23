require 'frappuccino/source'
require 'frappuccino/inject'

module Frappuccino
  class Stream
    include Observable
    
    def initialize(source)
      source.extend(Frappuccino::Source).add_observer(self)
    end

    def update(event)
      changed
      notify_observers(event)
    end

    def map(&blk)
      Map.new(self, &blk)
    end
    
    def inject(start, &blk)
      Inject.new(self, start, &blk)
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
