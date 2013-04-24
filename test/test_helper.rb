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

