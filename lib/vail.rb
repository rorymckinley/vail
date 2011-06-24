require 'beep'
require 'yaml'

['vail/config', 'vail/dot_dash', 'vail/translate', 'vail/generator', 'vail/command/sound'].each do |f|
  require File.join(File.dirname(__FILE__), f)
end

module Vail
  ConfigPath = File.join(File.dirname(__FILE__), '..', 'config', 'default.yaml')
end
