# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_tokenizable}
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Enrique Garcia Cota}, %q{Francisco de Juan}]
  s.date = %q{2012-03-20}
  s.description = %q{Make ActiveRecord models easily searchable via tokens.}
  s.email = %q{github@splendeo.es}
  s.extra_rdoc_files = [
    "LICENSE",
    "README",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "acts_as_tokenizable.gemspec",
    "init.rb",
    "lib/acts_as_tokenizable.rb",
    "lib/acts_as_tokenizable/acts_as_tokenizable.rb",
    "lib/acts_as_tokenizable/string_utils.rb",
    "lib/tasks/acts_as_tokenizable.rake",
    "test/helper.rb",
    "test/test_acts_as_tokenizable.rb"
  ]
  s.homepage = %q{http://github.com/splendeo/acts_as_tokenizable}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Acts as tokenizable}
  s.test_files = [
    "test/helper.rb",
    "test/test_acts_as_tokenizable.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<babosa>, ["~> 0.3.7"])
    else
      s.add_dependency(%q<babosa>, ["~> 0.3.7"])
    end
  else
    s.add_dependency(%q<babosa>, ["~> 0.3.7"])
  end
end

