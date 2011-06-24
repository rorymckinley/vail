module Vail
  module Command
    class Pause
      def initialize(type)
        @type = type
      end
      def execute(config)
        sleep(config[@type]["pause"].to_f/1000.0)
      end
    end
  end
end
