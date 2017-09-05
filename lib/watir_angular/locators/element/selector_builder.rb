module WatirAngular
  module Locators
    class Element
      class SelectorBuilder < Watir::Locators::Element::SelectorBuilder

        private

        def assert_valid_as_attribute(attribute)
          return if ng_attribute?(attribute)
          super
        end

        def ng_attribute?(attribute)
          ng_attributes.include? attribute[/^ng_(.+)$/, 1]
        end

        def ng_attributes
          %w[app bind bind_html bind_template blur change checked class
class_even class_odd click cloak controller copy csp cut dblclick disabled focus
form hide href if include init jq keydown keypress keyup list maxlength
minlength model model_options mousedown mouseenter mouseleave mousemove mouseover
mouseup non_bindable open options paste pluralize readonly repeat required selected
show src srcset style submit switch transclude value]
        end
      end
    end
  end
end
