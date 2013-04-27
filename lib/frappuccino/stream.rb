# before we require all of the subclasses, we need to have Stream defined
module Frappuccino
  class Stream
  end
end

require 'frappuccino/source'
require 'frappuccino/inject'

require 'frappuccino/stream/map'
require 'frappuccino/stream/select'
require 'frappuccino/stream/zip'

module Frappuccino
  class Stream
    include Observable

    def initialize(*sources)
      sources.each do |source|
        source.extend(Frappuccino::Source).add_observer(self)
      end
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

    def zip(stream)
      Zip.new(self, stream)
    end

    def all?(&blk)
      raise NotImplementedError, "#all doesn't make sense with infinite streams"
    end

    def any?(&blk)
      raise NotImplementedError, "#any doesn't make sense with infinite streams, it possibly could resolve in ⊥. You probably want #first or #select."
    end

    def on_value(&blk)
      callbacks << blk
    end

    def self.merge(stream_one, stream_two)
      new(stream_one, stream_two)
    end

    protected

    def occur(value)
      callbacks.each do |callback|
        callback.call(value)
      end

      changed
      notify_observers(value)
    end

    def callbacks
      @callbacks ||= []
    end
  end
end
