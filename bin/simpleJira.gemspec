Gem::Specification.new do |s|
  s.name        = 'simpleJira'
  s.version     = '1.0.0'
  s.date        = '2013-01-20'
  s.summary     = "A simple Ruby gem for the JIRA REST API."
  s.description = "A simple Ruby gem for the JIRA REST API."
  s.authors     = ["Tom Van Eyck"]
  s.email       = 'tomvaneyck@gmail.com'
  s.homepage    = 'https://github.com/vaneyckt/SimpleJira'

  s.add_runtime_dependency 'faraday', '>= 0.8.4'
  s.add_runtime_dependency 'faraday_middleware', '>= 0.9.0'
end
