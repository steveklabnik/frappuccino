require 'simplecov'
SimpleCov.start do
  add_filter do |source_file|
    source_file.filename =~ /test/
  end
end

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'

def to_array(stream)
  pushed = []
  stream.on_value do |value|
    pushed << value
  end

  pushed
end

def to_prop(ini, stream)
  Frappuccino::Property.new(ini, stream)
end

class Button
  def push
    emit(:pushed)
  end
end

class PlusOneButton
  def push
    emit(:+)
  end
end

class MinusOneButton
  def push
    emit(:-)
  end
end

class Points
  def POINTS!
    emit(:POINTS!)
  end
end

class CounterButton
  def initialize(ini = 0)
    @count = ini
  end

  def push
    emit(@count)
    @count += 1
  end
end

class Observer
  def initialize(&blk)
    @block = blk
  end

  def update(value)
    @block.call(value)
  end
end

