# -*- encoding: utf-8 -*-
# stub: ranked-model 0.4.8 ruby lib

Gem::Specification.new do |s|
  s.name = "ranked-model".freeze
  s.version = "0.4.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Matthew Beale".freeze]
  s.date = "2022-02-07"
  s.description = "ranked-model is a modern row sorting library built for Rails 4.2+. It uses ARel aggressively and is better optimized than most other libraries.".freeze
  s.email = ["matt.beale@madhatted.com".freeze]
  s.homepage = "https://github.com/mixonic/ranked-model".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.15".freeze
  s.summary = "An acts_as_sortable replacement built for Rails 4.2+".freeze

  s.installed_by_version = "3.4.15" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activerecord>.freeze, [">= 4.2"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3"])
  s.add_development_dependency(%q<rspec-its>.freeze, [">= 0"])
  s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
  s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.7.0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 12.3.3"])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
  s.add_development_dependency(%q<pry>.freeze, [">= 0"])
end
