require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Vail::Command::Pause do
  it "should pause for the number of milliseconds specified in the config for the relevant type of pause" do
    p = Vail::Command::Pause.new('blah')
    p.should_receive(:sleep).with(0.50)
    p.execute({'blah' => { 'pause' => 500 }})
  end
end

