require 'minitest/autorun'

class Button
  def push
    emit(:pushed)
  end
end

