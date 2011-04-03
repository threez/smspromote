# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smspromote}
  s.version = "0.0.7"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.authors = ["Vincent Landgraf"]
  s.date = %q{2011-02-27}
  s.description = %q{Library that provides access to the smspromote.de sms gateway service.}
  s.email = ["vilandgr@googlemail.com"]
  s.files = ["lib/smspromote/encoding.rb", "lib/smspromote/gateway.rb", "lib/smspromote/message.rb", "lib/smspromote.rb", "LICENSE", "README.rdoc"]
  s.homepage = %q{http://github.com/threez/smspromote}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{this gem helps sending sms using the smspromote.de sms gateway}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
