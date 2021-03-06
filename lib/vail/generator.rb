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

    def to_morse(text)
      convert_to_instructions(text).each do |instruction_set|
        instruction_set.each do |i|
          execute_instruction(i)
        end
      end
    end

    def settings
      @config.reject { |key, value| [Dot,Dash].include? key }
    end

    private

    def convert_to_instructions(text)
      lines = text.split("\n")

      # the last line does not get a line pause - so handle it first
      
      last_line = repeat(build_instructions(lines.pop))

      lines.inject([]) do |store,line|
        store + (repeat(build_instructions(line)) << [Command::Pause.new('line')])
      end + last_line
    end

    def build_instructions(phrase)
      instructions = []

      phrase.each_char do |char|
        if char == " "
          instructions << Command::Pause.new('group')
        else
          morse = Translate.to_morse(char)
          instructions << Command::Sound.new(morse)
          instructions << Command::Pause.new('letter')
        end
      end

      instructions
    end

    def repeat(instructions)
      # Add a repetition pause for the repeats only
      (@config["repetitions"]["repeat"]).times.inject([]) do 
        |r,i| r << (instructions +[Command::Pause.new("repetitions")])
      end << instructions
    end

    def execute_instruction(instruction)
      if instruction.is_a? Hash
        sleep(instruction[:instruction])
      else
        instruction.execute(@config)
      end
    end
  end
end
