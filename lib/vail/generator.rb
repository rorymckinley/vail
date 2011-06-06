module Vail
  class Generator
    def initialize
      @config = Config.get_settings
      Dot.class_variable_set(:@@duration, @config[:dot][:duration])
      Dot.class_variable_set(:@@pause, @config[:dot][:pause])
      Dash.class_variable_set(:@@duration, @config[:dash][:duration])
      Dash.class_variable_set(:@@pause, @config[:dash][:pause])
    end
    def to_morse(letter)
      morse = Translate.to_morse(letter)
      Beep::Sound.generate(morse.map { |dotdash| dotdash.to_sound(@config[:frequency]) }) 
    end
  end
end
