require 'observer'

module Frppuccino
  module Source
    def self.extended(object)
      object.extend(Observable)
    end

    def emit(value)
      changed
      notify_observers(value)
    end
  end
end
