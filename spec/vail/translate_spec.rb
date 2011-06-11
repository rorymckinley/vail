require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vail::Translate do
  it "should return a morse representation of a letter" do
    ("a".."z").each do |l|
      Vail::Translate.to_morse(l).should_not be_empty
    end
  end
  it "should not be case-sensitive" do
    ("A".."Z").each do |l|
      Vail::Translate.to_morse(l).should_not be_empty
    end
  end
end
