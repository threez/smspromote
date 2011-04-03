$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'smspromote'
require "rubygems" unless defined? Gem

spec = Gem::Specification.new do |s|
  s.name = "smspromote"
  s.version = SmsPromote::VERSION
  s.authors = ["Vincent Landgraf"]
  s.email = ["vilandgr@googlemail.com"]
  s.homepage = "http://github.com/threez/smspromote"
  s.summary = "this gem helps sending sms using the smspromote.de sms gateway"
  s.description = ""
  
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
 
  s.platform = Gem::Platform::RUBY
 
  s.required_rubygems_version = ">= 1.3.5"
 
  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.rdoc)
  s.executables = []
  s.require_path = 'lib'
end
 
begin
  require 'rspec/core/rake_task'
rescue LoadError
  task :spec do
    $stderr.puts '`gem install rspec` to run specs'
  end
else
  desc "Run specs"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w(-fs --color)
  end
end
 
begin
  require 'rake/gempackagetask'
rescue LoadError
  task(:gem) { $stderr.puts '`gem install rake` to package gems' }
else
  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.gem_spec = spec
  end
  task :gem => :gemspec
end
 
desc "install the gem locally"
task :install => :package do
  sh %{gem install pkg/#{spec.name}-#{spec.version}}
end
 
desc "create a gemspec file"
task :gemspec do
  File.open("#{spec.name}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
 
task :package => :gemspec
task :default => [:spec, :gemspec]
