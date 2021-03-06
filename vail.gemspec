# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vail}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rory McKinley"]
  s.date = %q{2011-07-04}
  s.default_executable = %q{vail}
  s.description = %q{Vail generates audible morse code. Currently it only works on Linux distros that have the beep utility installed. This is hopefully a temporary limitation}
  s.email = %q{rorymckinley@gmail.com}
  s.executables = ["vail"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/vail",
    "config/default.yaml",
    "lib/vail.rb",
    "lib/vail/command/pause.rb",
    "lib/vail/command/sound.rb",
    "lib/vail/config.rb",
    "lib/vail/dot_dash.rb",
    "lib/vail/generator.rb",
    "lib/vail/translate.rb",
    "spec/spec_helper.rb",
    "spec/vail/command/pause_spec.rb",
    "spec/vail/command/sound_spec.rb",
    "spec/vail/generator_spec.rb",
    "spec/vail/translate_spec.rb",
    "spec/vail_spec.rb",
    "vail.gemspec"
  ]
  s.homepage = %q{http://github.com/rorymckinley/vail}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A simple gem to generate audible morse code}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<beep>, ["~> 0.0.1"])
      s.add_runtime_dependency(%q<trollop>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<beep>, ["~> 0.0.1"])
      s.add_dependency(%q<trollop>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<beep>, ["~> 0.0.1"])
    s.add_dependency(%q<trollop>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

