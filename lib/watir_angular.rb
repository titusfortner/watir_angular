require "watir"

Watir::Locators::Element::SelectorBuilder.send(:remove_const, :WILDCARD_ATTRIBUTE)
Watir::Locators::Element::SelectorBuilder::WILDCARD_ATTRIBUTE = /^(aria|data|ng)_(.+)$/

module WatirAngular
  def self.wait_for_angular(browser, timeout = nil)
    browser.wd.manage.timeouts.script_timeout = timeout if timeout
    file = File.expand_path("../waitForAngular.js", __FILE__)
    js = File.read(file)
    script = "return (#{js}).apply(null, arguments)"

    error = browser.wd.execute_async_script(script, 'body')
    Watir.logger.warn error if error
  end

  def self.inject_wait(browser)
    browser.after_hooks.add ->(browser) { wait_for_angular(browser) }
  end
end
