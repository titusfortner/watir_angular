# Code on this page is based on code by westlm1@NW110283.nwie.net
# From https://github.com/watir/watir/pull/387

require "watir"

Watir::Locators::Element::SelectorBuilder.send(:remove_const, :WILDCARD_ATTRIBUTE)
Watir::Locators::Element::SelectorBuilder::WILDCARD_ATTRIBUTE = /^(aria|data|ng)_(.+)$/

module WatirAngular
  def self.wait_for_angular(browser, timeout: Watir.default_timeout)
    wd = browser.wd
    angular_element = "document.querySelectorAll('[ng-app]')[0]"
    wd.execute_script("angular.element(#{angular_element}).scope().pageFinishedRendering = false")
    wd.execute_script("angular.getTestability(#{angular_element}).whenStable(function(){angular.element(#{angular_element}).scope().pageFinishedRendering = true})")
    browser.wait_until(timeout: timeout, message: "waiting for angular to render") do
      wd.execute_script("return angular.element(#{angular_element}).scope().pageFinishedRendering")
    end
  rescue Selenium::WebDriver::Error::InvalidElementStateError
    # no ng-app found on page, continue as normal
  rescue Selenium::WebDriver::Error::JavascriptError
    # angular not used in the application, continue as normal
  rescue Selenium::WebDriver::Error::UnknownError => ex
    # TODO - this may be a bug in chromedriver that it is not a JavaScriptError
    raise unless ex.message.include? "angular is not defined"
    # angular not used in the application, continue as normal
  end

  def self.inject_wait(browser)
    browser.after_hooks.add ->(browser) { wait_for_angular(browser) }
  end
end
