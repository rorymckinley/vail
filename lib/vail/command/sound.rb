module Vail
  module Command
    class Sound
      def initialize(morse)
        @morse = morse
      end

      def execute(config)
        Beep::Sound.generate(@morse.map { |dotdash| { :duration => config[dotdash]["duration"], :pause => config[dotdash]["pause"], :frequency => config["frequency"] }})
      end
    end
  end
end

