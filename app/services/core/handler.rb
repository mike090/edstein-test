# frozen_string_literal: true

module Core
  module Handler
    def plug_on(successor)
      @successor = successor
      self
    end

    def handle(msg, *args)
      return public_send msg, *args if respond_to? msg
      raise(NotImplementedError("#{msg} not emplemented!")) unless @successor
      return @successor.handle(msg, *args) if @successor.is_a?(Handler)
      return @successor.public_send(msg, *args) if @successor.respond_to? msg

      raise NotImplementedError, "#{msg} not emplemented!"
    end
  end
end
