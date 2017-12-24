require 'spec_helper'
require_relative '../lib/ewallet'

describe Ewallet do
  it "should be named after user if name isn't set" do
    full_name1 = random_name
    user1 = double('Some user', full_name: full_name1)
    ewallet1 = Ewallet.new(1910, user1, nil)
    expect(ewallet1.name).to eq("#{full_name1}'s e-wallet")

    full_name2 = random_name
    user2 = double('Other user', full_name: full_name2)
    ewallet2 = Ewallet.new(1911, user2, 'My wallet')
    expect(ewallet2.name).to eq('My wallet')
  end
end
