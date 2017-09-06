require 'webdrivers'
require "watir_angular"
require 'watirspec'

WatirSpec.implementation do |watirspec|
  opts = {}

  watirspec.name = :watir_angular
  watirspec.browser_class = Watir::Browser
  watirspec.browser_args = [:chrome, opts]

  watirspec.guard_proc = lambda do |watirspec_guards|
    watir_angular_guards = [:chrome]
    watir_angular_guards << :watir_angular

    watirspec_guards.any? { |guard| watir_angular_guards.include?(guard) }
  end
end

WatirSpec.run!
