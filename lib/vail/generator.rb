module Vail
  class Generator
    def initialize(config={})
      config = YAML.load(IO.read(ConfigPath)) if config.empty?
      
      @config = config.merge (
        {
          Dot => { "duration" => config["dot"]["duration"], "pause" => config["dot"]["pause"] },
          Dash => { "duration" => config["dash"]["duration"], "pause" => config["dash"]["pause"]}
        }
      )

      @config.merge! (
        case @config["repetitions"]
        when Hash
          {}
        when Fixnum
          { "repetitions" => { "repeat" => (@config["repetitions"] - 1), "pause" => 800 } }
        when NilClass
          { "repetitions" => { "repeat" => 0, "pause" => 800 } }
        end
      )
    end

    def to_morse(phrase)
      instructions = build_instructions(phrase)

      # Add a repetition pause to all but the last repeat
      repeated_instructions = (@config["repetitions"]["repeat"]).times.inject([]) do 
        |r,i| r << (instructions +[{ :command => :sleep, :instruction => @config["repetitions"]["pause"].to_f/1000.0}])
      end

      repeated_instructions << instructions

      (repeated_instructions).each do |instruction_set|
        instruction_set.each do |i|
          execute_instruction(i)
        end
      end
    end

    def settings
      @config.reject { |key, value| [Dot,Dash].include? key }
    end

    private

    def build_instructions(phrase)
      instructions = []

      phrase.each_char do |char|
        if char == " "
          instructions << { :command => :sleep, :instruction => @config["group"]["pause"].to_f/1000.0}
        else
          morse = Translate.to_morse(char)
          instructions << { 
            :command => :sound, 
            :instruction => morse.map { |dotdash| { :duration => @config[dotdash]["duration"], :pause => @config[dotdash]["pause"], :frequency => @config["frequency"] }}
          }
          instructions << { :command => :sleep, :instruction => @config["letter"]["pause"].to_f/1000.0}
        end
      end

      instructions
    end

    def execute_instruction(instruction)
      if instruction[:command] == :sound
        Beep::Sound.generate(instruction[:instruction])
      else
        sleep(instruction[:instruction])
      end
    end
  end
end
