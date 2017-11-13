# Code on Page is based on code by westlm1@NW110283.nwie.net
# From https://github.com/watir/watir/pull/387

require "watir"
require 'watir_angular/locators/element/selector_builder'

module WatirAngular
  class Browser < Watir::Browser
    def initialize(*args)
      super
      proc = ->(browser) { browser.wait_for_angular }
      @after_hooks.add(proc)
    end

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
      unless [" of undefined", "angular is not defined"].any? {|p| ex.message.include? p}
        raise
      end
      # angular not used in the application, continue as normal
    end

    def locator_namespace
      @locator_namespace ||= WatirAngular::Locators
    end
  end
end

#WatirAngular::Locators::Element::Locator = Watir::Locators::Element::Locator
#WatirAngular::Locators::Element::Validator = Watir::Locators::Element::Validator

# Behaviors for element subclasses to come from Watir rather than WatirAngular superclass element
#WatirAngular::Locators::Button::Locator = Watir::Locators::Button::Locator
#WatirAngular::Locators::Button::Validator = Watir::Locators::Button::Validator
#WatirAngular::Locators::Cell::Locator = Watir::Locators::Cell::Locator
#WatirAngular::Locators::Row::Locator = Watir::Locators::Row::Locator
#WatirAngular::Locators::TextArea::Locator = Watir::Locators::TextArea::Locator
#WatirAngular::Locators::TextField::Locator = Watir::Locators::TextField::Locator
#WatirAngular::Locators::TextField::Validator = Watir::Locators::TextField::Validator

