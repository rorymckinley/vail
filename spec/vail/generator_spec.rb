require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vail::Generator do
  before(:all) do
    @settings = { 
      :dot => { :duration => 100, :pause => 200 },
      :dash => { :duration => 300, :pause => 400 },
      :frequency => 250
    }
  end
  it "should load config data on initialisation" do
    Vail::Config.should_receive(:get_settings).and_return(@settings)
    Vail::Generator.new
  end
  it "should be able to generate the sound for a letter with a single dot" do
    Vail::Config.stub!(:get_settings).and_return(@settings)
    Vail::Translate.should_receive(:to_morse).with('E').and_return([Vail::Dot])
    Beep::Sound.should_receive(:generate).with([{ :duration => 100, :pause => 200, :frequency => 250 }])

    Vail::Generator.new.to_morse("E")
  end
  it "should be able to generate the sound for a letter with a single dash" do
    Vail::Config.stub!(:get_settings).and_return(@settings)
    Vail::Translate.should_receive(:to_morse).with('T').and_return([Vail::Dash])
    Beep::Sound.should_receive(:generate).with([{ :duration => 300, :pause => 400, :frequency => 250 }])

    Vail::Generator.new.to_morse("T")
  end
end

