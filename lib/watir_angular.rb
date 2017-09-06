# Code on Page is based on code by westlm1@NW110283.nwie.net
# From https://github.com/watir/watir/pull/387

require "watir"

require 'watir_angular/locators/element/locator'
require 'watir_angular/locators/element/selector_builder'
require 'watir_angular/locators/element/validator'

require 'watir_angular/locators/button/locator'
require 'watir_angular/locators/button/selector_builder'
require 'watir_angular/locators/button/selector_builder/xpath'
require 'watir_angular/locators/button/validator'

require 'watir_angular/locators/cell/locator'
require 'watir_angular/locators/cell/selector_builder'

require 'watir_angular/locators/row/locator'
require 'watir_angular/locators/row/selector_builder'

require 'watir_angular/locators/text_area/locator'
require 'watir_angular/locators/text_area/selector_builder'

require 'watir_angular/locators/text_field/locator'
require 'watir_angular/locators/text_field/selector_builder'
require 'watir_angular/locators/text_field/selector_builder/xpath'
require 'watir_angular/locators/text_field/validator'

module WatirAngular
  def wait_for_angular(timeout: Watir.default_timeout)
    angular_element = "document.querySelectorAll('[ng-app]')[0]"
    wd.execute_script("angular.element(#{angular_element}).scope().pageFinishedRendering = false")
    wd.execute_script("angular.getTestability(#{angular_element}).whenStable(function(){angular.element(#{angular_element}).scope().pageFinishedRendering = true})")
    wait_until(timeout: timeout, message: "waiting for angular to render") do
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
end

require 'extensions/watir/browser'
Watir.locator_namespace = WatirAngular::Locators

