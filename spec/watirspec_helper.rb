require 'webdrivers'
require "watir_angular"
require 'watirspec'

WatirSpec.htmls << File.expand_path("../watirspec/html", __FILE__)

WatirSpec.implementation do |watirspec|
  opts = {}

  watirspec.name = :watir_angular
  watirspec.browser_class = Watir::Browser
  watirspec.browser_args = [:chrome, opts]

  watirspec.guard_proc = lambda do |watirspec_guards|
    watir_angular_guards = %i[chrome watir_angular relaxed_locate]
    watirspec_guards.any? { |guard| watir_angular_guards.include?(guard) }
  end
end

WatirSpec.run!
