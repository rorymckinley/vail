require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Vail::Command::Sound do
  it "should generate sound with the correct settings for a dot or dash" do
    s = Vail::Command::Sound.new([Vail::Dot, Vail::Dash])
    Beep::Sound.should_receive(:generate).with([{ :duration => 100, :pause => 200, :frequency => 500 }, { :duration => 300, :pause => 400, :frequency => 500 }])
    s.execute({ Vail::Dot => { "duration" => 100, "pause" => 200 }, Vail::Dash => { "duration" => 300, "pause" => 400 }, "frequency" => 500 })
  end
end

