require 'watirspec_helper'

describe WatirAngular do
  before do
    browser.goto(WatirSpec.url_for("ng_attributes.html"))
  end

  it "adds after hook" do
    expect(browser.after_hooks.size).to eq 1
  end

  it "uses ng-model and ng-class" do
    browser.select(ng_model: 'home').select('sky')

    light_blue = "173, 216, 230"
    expect(browser.div(ng_class: 'home').style('background-color')).to include light_blue
  end

  it "uses ng-click" do
    3.times { browser.button(ng_click: true).click }
    expect(browser.div(class: 'ng-binding').text[/(\d+)/, 1]).to eq '3'
  end
end
