require 'watirspec_helper'

describe WatirAngular do
  before do
    browser.goto(WatirSpec.url_for("ng_attributes.html"))
  end

  describe "WILDCARD_ATTRIBUTE" do
    it "creates custom ng methods" do
      expect(browser.text_field(id: 'foo').ng_foo).to eq 'name'
    end

    it "creates custom ng locators" do
      expect(browser.text_field(ng_foo: 'name').id).to eq 'foo'
    end
  end

  describe "#wait_for_angular" do
    it "execute scripts" do
      expect(browser.wd).to receive(:execute_async_script).and_return(true).once
      WatirAngular.wait_for_angular(browser)
    end

    it "accepts timeout" do
      expect { WatirAngular.wait_for_angular(browser) }.to_not raise_exception
    end
  end

  describe "#inject_wait" do
    after { browser.after_hooks.delete(browser.after_hooks[0])}

    it "adds after hook with browser only" do
       WatirAngular.inject_wait(browser)
      expect(browser.after_hooks.size).to eq 1
    end

    it "executes after hook" do
      WatirAngular.inject_wait(browser)
      expect(browser.wd).to receive(:execute_async_script).and_return(true).twice
      expect { 2.times { browser.refresh } }.to_not raise_error
    end

  end
end
