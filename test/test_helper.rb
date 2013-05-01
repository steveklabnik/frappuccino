require 'simplecov'
SimpleCov.start do
  add_filter do |source_file|
    source_file.filename =~ /test/
  end
end

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'

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
  def initialize
    @count = 0
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

