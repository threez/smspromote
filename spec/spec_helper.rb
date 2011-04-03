$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require "smspromote"

unless defined? :describe
  begin
    require "spec"
  rescue LoadError
    require "rubygems"
    require "spec"
  end
end

def txt_file(name)
  path = File.join(File.dirname(__FILE__), "#{name}.txt")
  if "".respond_to? :encode # ruby 1.9
    File.open(path, "r:#{name}") do |f|
      f.read
    end
  else # ruby 1.8
    File.read(path)
  end
end

API_KEY = SmsPromote::Gateway.read_api_key_from_file
