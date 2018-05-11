# require: message_handler

class App
  def self.current
    @current ||= self.new
  end

  def run
    # Main run loops
    until STDIN.eof?
      # Check for inbound messages, esp. signals.
      current_message = InputManager.current.shift
      if current_message
        message = RequestHeader.new(current_message)
        MessageHandler.current.execute(message, HyperVisor.current)
      else
        HyperVisor.current.tick
      end
    end
  end
end
Main.run