# Code on Page is based on code by westlm1@NW110283.nwie.net
# From https://github.com/watir/watir/pull/387

require "watir"

require 'watir_angular/locators/element/locator'
require 'watir_angular/locators/element/selector_builder'
require 'watir_angular/locators/element/validator'

module WatirAngular
  def wait_for_angular(browser, timeout: Watir.default_timeout)
    driver = browser.wd
    angular_element = "document.querySelectorAll('[ng-app]')[0]"
    driver.execute_script("angular.element(#{angular_element}).scope().pageFinishedRendering = false")
    driver.execute_script("angular.getTestability(#{angular_element}).whenStable(function(){angular.element(#{angular_element}).scope().pageFinishedRendering = true})")
    browser.wait_until(timeout: timeout, message: "waiting for angular to render") do
      driver.execute_script("return angular.element(#{angular_element}).scope().pageFinishedRendering")
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
end

require 'extensions/watir/browser'
Watir.locator_namespace = WatirAngular::Locators
