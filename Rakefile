$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'smspromote'
require "rubygems" unless defined? Gem
 
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
 
task :default => :spec
