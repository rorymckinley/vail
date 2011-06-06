module Vail
  class Dot
    def self.to_sound(frequency)
      { :duration => @@duration, :pause => @@pause, :frequency => frequency }
    end
  end
  class Dash
    def self.to_sound(frequency)
      { :duration => @@duration, :pause => @@pause, :frequency => frequency }
    end
  end
end
