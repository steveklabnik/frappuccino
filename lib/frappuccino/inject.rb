module Frappuccino
  class Inject
    def initialize(source, start, &blk)
      @source = source
      @start = start
      @block = blk
    end

    def to_i
      @source.values.inject(@start, &@block)
    end
  end
end
