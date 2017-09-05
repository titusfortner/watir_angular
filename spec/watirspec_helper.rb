require 'webdrivers'
require "watir_angular"
require 'watirspec'

WatirSpec.implementation do |watirspec|
  opts = {}

  watirspec.name = :watir_angular
  watirspec.browser_class = Watir::Browser
  watirspec.browser_args = [:chrome, opts]
end

WatirSpec.run!
