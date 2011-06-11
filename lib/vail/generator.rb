module Vail
  class Generator
    def initialize(config)
      @config = config
      @config[:repetitions] ||= 1
      Dot.class_variable_set(:@@duration, @config[:dot][:duration])
      Dot.class_variable_set(:@@pause, @config[:dot][:pause])
      Dash.class_variable_set(:@@duration, @config[:dash][:duration])
      Dash.class_variable_set(:@@pause, @config[:dash][:pause])
    end
    def to_morse(phrase)
      instructions = build_instructions(phrase)

      (@config[:repetitions].times.inject([]) { |r,i| r << instructions }).each do |instructions|
        instructions.each do |i|
          execute_instruction(i)
        end
      end
    end

    private

    def build_instructions(phrase)
      instructions = []

      phrase.each_char do |char|
        if char == " "
          instructions << { :command => :sleep, :instruction => @config[:group][:pause].to_f/1000.0}
        else
          morse = Translate.to_morse(char)
          instructions << { :command => :sound, :instruction => morse.map { |dotdash| dotdash.to_sound(@config[:frequency]) }}
          instructions << { :command => :sleep, :instruction => @config[:letter][:pause].to_f/1000.0}
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
