# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airs/version'

Gem::Specification.new do |gem|
  gem.name          = "airs"
  gem.version       = Airs::VERSION
  gem.authors       = ["Patrick Brisbin"]
  gem.email         = ["pbrisbin@gmail.com"]
  gem.description   = %q{Recieve a Push notificaiton when favorite shows are airing}
  gem.summary       = %q{Scrapes next-episode.net for TV shows that are airing based on a "watch list", sends you a push notification using pushover.net}
  gem.homepage      = "https://github.com/pbrisbin/airs"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'curb'
  gem.add_runtime_dependency 'nokogiri'
end
