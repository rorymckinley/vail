require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vail::Generator do
  it "should load config data on initialisation" do
    Vail::Config.should_receive(:get_settings)
    Vail::Generator.new
  end
  it "should convert a letter into a series of dots and dashes" do
    pending
  end
end

