require 'minitest/autorun'

require 'simplecov'
SimpleCov.start do
  add_filter do |source_file|
    source_file.filename =~ /test/
  end
end

require 'coveralls'
Coveralls.wear!

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

