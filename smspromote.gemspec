# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smspromote}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.authors = ["Vincent Landgraf"]
  s.date = %q{2010-07-26}
  s.description = %q{}
  s.email = ["vilandgr@googlemail.com"]
  s.files = ["lib/smspromote/encoding.rb", "lib/smspromote/gateway.rb", "lib/smspromote/message.rb", "lib/smspromote.rb", "LICENSE", "README.rdoc"]
  s.homepage = %q{http://github.com/threez/smspromote}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{this gem helps sending sms using the smspromote.de sms gateway}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, [">= 1.6.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rest-client>, [">= 1.6.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rest-client>, [">= 1.6.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
