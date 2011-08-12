# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'red_query/version'

Gem::Specification.new do |s|
  s.name        = 'red_query'
  s.version     = RedQuery::VERSION
  s.authors     = ['Julius Eckert']
  s.email       = ['eckert.julius@gmail.com']
  s.homepage    = ''
  s.summary     = %q{Provides DOM, Ajax, JSON functionality for Red. Heavy usage of jQuery.}
  s.description = %q{Provides DOM, Ajax, JSON functionality for Red. Heavy usage of jQuery.}

  s.rubyforge_project = 'red_query'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
