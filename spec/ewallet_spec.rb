require 'spec_helper'
require_relative '../lib/ewallet'

describe Ewallet do
  it "should be named after user if name isn't set" do
    full_name = random_name
    user = double("Some user", :full_name => full_name)
    ewallet = Ewallet.new(1910, user, nil)
    expect(ewallet.name) == "#{full_name}'s e-wallet"
  end
end
