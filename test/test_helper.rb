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
