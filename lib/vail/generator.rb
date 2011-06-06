module Vail
  class Generator
    def initialize
      @config = Config.get_settings
      Dot.class_variable_set(:@@duration, @config[:dot][:duration])
      Dot.class_variable_set(:@@pause, @config[:dot][:pause])
      Dash.class_variable_set(:@@duration, @config[:dash][:duration])
      Dash.class_variable_set(:@@pause, @config[:dash][:pause])
    end
    def to_morse(phrase)
      phrase.each_char do |char|
        if char == " "
          sleep(@config[:group][:pause].to_f/1000.0)
          next
        end

        morse = Translate.to_morse(char)
        Beep::Sound.generate(morse.map { |dotdash| dotdash.to_sound(@config[:frequency]) }) 
        sleep(@config[:letter][:pause].to_f/1000.0)
      end
    end
  end
end
