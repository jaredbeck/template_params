# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "template_params/version"

Gem::Specification.new do |spec|
  spec.name = "template_params"
  spec.version = TemplateParams::VERSION
  spec.authors = ["Jared Beck"]
  spec.email = ["jared@jaredbeck.com"]
  spec.summary = "Parameter assertions for view templates"
  spec.homepage = "https://github.com/jaredbeck/template_params"
  spec.license = "MIT"
  spec.files = `git ls-files -z`.
    split("\x0").
    reject { |f| f.match(%r{^(bin|test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = []
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.2'
  spec.add_runtime_dependency "method_source", [">= 0.8.2", "< 0.10"]
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rubocop", "~> 0.50.0"
end
