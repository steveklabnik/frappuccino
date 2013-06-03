# encoding: utf-8

# before we require all of the subclasses, we need to have Stream defined
module Frppuccino
  class Stream
  end
end

require 'frppuccino/source'

require 'frppuccino/stream/map'
require 'frppuccino/stream/select'
require 'frppuccino/stream/zip'
require 'frppuccino/stream/drop'
require 'frppuccino/stream/scan'
require 'frppuccino/stream/take'

def not_implemented(m, message)
  define_method m do |*args, &blk|
    raise NotImplementedError, "##{m} is not supported, because #{message}."
  end
end

module Frppuccino
  class Stream
    include Observable

    def initialize(*sources)
      sources.each do |source|
        source.extend(Frppuccino::Source).add_observer(self)
      end
    end

    def update(event)
      occur(event)
    end

    def count(*args, &blk)
      stream = if args.count > 0
        self.select { |value| value == args.first }
      elsif blk
        self.select { |value| blk.call(value) }
      else
        self
      end

      Property.new(0, stream.scan(0) { |last| last + 1 })
    end

    not_implemented(:cycle, "it relies on having a end to the Enumerable")
    not_implemented(:all?,  "it needs a stream that terminates.")
    not_implemented(:chunk, "it needs a stream that terminates.")
    not_implemented(:any?,  "it could resolve to ⊥. You probably want #select")
    not_implemented(:find,  "it could resolve to ⊥. You probably want #select")

    alias :detect :find

    def map(hash = nil, &blk)
      blk = lambda { |event| hash.fetch(event) { hash[:default] } } if hash
      Map.new(self, &blk)
    end
    alias :collect :map
    alias :map_stream :map

    def drop(n)
      Drop.new(self, n)
    end

    def take(n)
      Take.new(self, n)
    end

    def inject(start, &blk)
      Property.new(start, self.scan(start, &blk))
    end

    def select(&blk)
      Select.new(self, &blk)
    end

    def zip(stream)
      Zip.new(self, stream)
    end

    def scan(zero, &blk)
      Scan.new(self, zero, &blk)
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
