require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vail::Generator do
  before(:each) do
    @settings = { 
      "dot" => { "duration" => 100, "pause" => 200 },
      "dash" => { "duration" => 300, "pause" => 400 },
      "frequency" => 250,
      "letter" => { "pause" => 100 },
      "group" => { "pause" => 200 }
    }
  end
  it "should load default settings upon initialisation if none are provided" do
    IO.should_receive(:read).with(Vail::ConfigPath).and_return('blah')
    YAML.should_receive(:load).with('blah').and_return(@settings)
    Vail::Generator.new
  end
  it "should generate the sound for a letter with a single dot" do
    Vail::Translate.should_receive(:to_morse).with('E').and_return([Vail::Dot])
    Beep::Sound.should_receive(:generate).with([{ :duration => 100, :pause => 200, :frequency => 250 }])

    Vail::Generator.new(@settings).to_morse("E")
  end
  it "should generate the sound for a letter with a single dash" do
    Vail::Translate.should_receive(:to_morse).with('T').and_return([Vail::Dash])
    Beep::Sound.should_receive(:generate).with([{ :duration => 300, :pause => 400, :frequency => 250 }])

    Vail::Generator.new(@settings).to_morse("T")
  end
  it "should generate morse for a letter that has a multiple dots and dashes" do
    sound_parameters = [
      { :duration => 300, :pause => 400, :frequency => 250 },
      { :duration => 300, :pause => 400, :frequency => 250 },
      { :duration => 100, :pause => 200, :frequency => 250 }
    ]
    Vail::Translate.should_receive(:to_morse).with('G').and_return([Vail::Dash, Vail::Dash, Vail::Dot])
    Beep::Sound.should_receive(:generate).with(sound_parameters)

    Vail::Generator.new(@settings).to_morse("G")
  end

  it "should provide an additional pause after a letter is completed" do
    Vail::Translate.stub!(:to_morse).and_return([Vail::Dash, Vail::Dash, Vail::Dot])
    Beep::Sound.should_receive(:generate)

    g = Vail::Generator.new(@settings)  
    g.should_receive(:sleep).with(@settings["letter"]["pause"].to_f/1000.0)
    g.to_morse("G")
  end

  it "should generate morse for a group of letters" do
    sound_parameters_G = [
      { :duration => 300, :pause => 400, :frequency => 250 },
      { :duration => 300, :pause => 400, :frequency => 250 },
      { :duration => 100, :pause => 200, :frequency => 250 }
    ]
    sound_parameters_O = [
      { :duration => 300, :pause => 400, :frequency => 250 },
      { :duration => 300, :pause => 400, :frequency => 250 },
      { :duration => 300, :pause => 400, :frequency => 250 },
    ]
    Vail::Translate.stub!(:to_morse).with('G').and_return([Vail::Dash, Vail::Dash, Vail::Dot])
    Vail::Translate.stub!(:to_morse).with('O').and_return([Vail::Dash, Vail::Dash, Vail::Dash])

    Beep::Sound.should_receive(:generate).with(sound_parameters_G).ordered
    Beep::Sound.should_receive(:generate).with(sound_parameters_O).ordered

    g = Vail::Generator.new(@settings)
    g.should_receive(:sleep).with(@settings["letter"]["pause"].to_f/1000.0).twice
    g.to_morse("GO")
  end

  it "should pause between groups of words" do
    Vail::Translate.stub!(:to_morse).with('G').and_return([Vail::Dash, Vail::Dash, Vail::Dot])
    Vail::Translate.stub!(:to_morse).with('O').and_return([Vail::Dash, Vail::Dash, Vail::Dash])

    Beep::Sound.stub!(:generate)

    g = Vail::Generator.new(@settings)
    g.should_receive(:sleep).with(@settings["letter"]["pause"].to_f/1000.0).twice.ordered
    g.should_receive(:sleep).with(@settings["group"]["pause"].to_f/1000.0).ordered
    g.should_receive(:sleep).with(@settings["letter"]["pause"].to_f/1000.0).twice.ordered
    g.to_morse("GO GO")
  end

  it "should allow a phrase to be repeated" do
    Vail::Translate.stub!(:to_morse).with('G').and_return([Vail::Dash, Vail::Dash, Vail::Dot])
    Vail::Translate.stub!(:to_morse).with('O').and_return([Vail::Dash, Vail::Dash, Vail::Dash])

    Beep::Sound.stub!(:generate)

    settings = @settings.merge("repetitions" => { 'repeat' => 1, 'pause' => 800 })

    g = Vail::Generator.new(settings)
    g.should_receive(:sleep).with(settings["letter"]["pause"].to_f/1000.0).exactly(8).times
    g.should_receive(:sleep).with(settings["group"]["pause"].to_f/1000.0).twice
    g.should_receive(:sleep).with(settings["repetitions"]["pause"].to_f/1000.0)
    g.to_morse("GO GO")
  end

  it "should accept a scalar value (old settings format) for the repetitions settings key and set a default repetition pause" do
    Vail::Generator.new(@settings.merge("repetitions" => 5)).settings.should == @settings.merge({"repetitions" => { "repeat" => 4, "pause" => 800}})
  end

  it "should be able to return the current settings object including any defaults applied" do
    Vail::Generator.new(@settings).settings.should == @settings.merge("repetitions" => { "repeat" => 0, "pause" => 800})
  end
end

