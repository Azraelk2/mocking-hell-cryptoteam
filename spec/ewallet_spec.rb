require 'spec_helper'
require_relative '../lib/ewallet'

describe Ewallet do
  context '#initialize' do
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

    it 'should inherits user account data from init' do
      user = double('Some user', full_name: 'Jan Iwaszkiewicz', \
                                 pesel: '123456789', \
                                 birthday_date: '20-03-1997', city: 'Gdansk')
      ewallet = Ewallet.new(1, user, 'Na alkoholizacje')
      expect(ewallet.user.full_name).to eq('Jan Iwaszkiewicz')
      expect(ewallet.user.pesel).to eq('123456789')
      expect(ewallet.user.birthday_date).to eq('20-03-1997')
      expect(ewallet.user.city).to eq('Gdansk')
    end
  end
end
