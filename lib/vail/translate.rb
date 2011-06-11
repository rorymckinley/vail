module Vail
  class Translate
    Morse = {
      "a" => [Dot, Dash],
      "b" => [Dash, Dot, Dot, Dot],
      "c" => [Dash, Dot, Dash, Dot],
      "d" => [Dash, Dot, Dot],
      "e" => [Dot],
      "f" => [Dot, Dot, Dash, Dot],
      "g" => [Dash, Dash, Dot],
      "h" => [Dot, Dot, Dot, Dot],
      "i" => [Dot, Dot],
      "j" => [Dot, Dash, Dash, Dash ],
      "k" => [Dash, Dot, Dash ],
      "l" => [Dot, Dash, Dot, Dot],
      "m" => [Dash, Dash],
      "n" => [Dash, Dot],
      "o" => [Dash, Dash, Dash],
      "p" => [Dot, Dash, Dash, Dot],
      "q" => [Dash, Dash, Dot, Dash],
      "r" => [Dot, Dash, Dot],
      "s" => [Dot, Dot, Dot], 
      "t" => [Dash], 
      "u" => [Dot, Dot, Dash], 
      "v" => [Dot, Dot, Dot, Dash], 
      "w" => [Dot, Dash, Dash],
      "x" => [Dash, Dot, Dot, Dash],
      "y" => [Dash, Dot, Dash, Dash],
      "z" => [Dash, Dash, Dot, Dot]
    }
    def self.to_morse(letter)
      Morse[letter.downcase] || []
    end
  end
end
