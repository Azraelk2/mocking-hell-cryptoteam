require 'spec_helper'

describe Ewallet do
  it "should be named after user if name isn't set" do
    full_name = random_name
    user = mock_model User, full_name: full_name
    ewallet = Ewallet.new
    ewallet.user = user
    ewallet.name.should == "#{full_name}'s e-wallet"
  end
end
