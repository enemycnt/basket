# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'basket/version'

Gem::Specification.new do |spec|
  spec.name          = "basket"
  spec.version       = Basket::VERSION
  spec.authors       = ["Nikolay Topkaridi"]
  spec.email         = ["enemycnt@gmail.com"]
  spec.summary       = %q{SALES TAXES app}
  spec.description   = %q{Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical
                          products that are exempt. Import duty is an additional sales
                          tax applicable on all imported goods at a rate of 5%, with no exemptions.

                          When I purchase items I receive a receipt that lists the name of all the items and their price
                          (including tax), finishing with the total cost of the items, and the total amounts of sales
                          taxes paid. The rounding rules for sales tax are that for a tax rate of n%, a shelf
                            price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"

end
