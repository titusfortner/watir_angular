module Watir

  class Browser
    include WatirAngular

    # TODO - reimplement with Watir Executor when available

    alias_method :watir_initialize, :initialize

    def initialize(*args)
      watir_initialize(*args)
      proc = ->(browser) { browser.wait_for_angular }
      @after_hooks.add(proc)
    end
  end # Browser
end # Watir
