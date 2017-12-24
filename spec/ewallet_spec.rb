require 'spec_helper'
require_relative '../lib/ewallet'

describe Ewallet do
  context '#initialize' do
    let(:id) { 1 }

    let(:name_rand) { random_name }

    let(:user1) do
      double('Some user', full_name: name_rand)
    end

    let(:user2) do
      double('Other user')
    end

    let(:user3) do
      double('Some user', full_name: 'Jan Iwaszkiewicz', \
                          pesel: '123456789', \
                          birthday_date: '20-03-1997', city: 'Gdansk')
    end

    let(:ewallet1) { Ewallet.new(id, user1, nil) }
    let(:ewallet2) { Ewallet.new(id, user2, 'My wallet') }
    let(:ewallet3) { Ewallet.new(id, user3, 'Na Wódeczkę') }

    it "should be named after user if name isn't set" do
      expect(ewallet1.name).to eq("#{name_rand}'s e-wallet")
      expect(ewallet2.name).to eq('My wallet')
    end

    it 'should inherits user account data from init' do
      expect(ewallet3.user.full_name).to eq('Jan Iwaszkiewicz')
      expect(ewallet3.user.pesel).to eq('123456789')
      expect(ewallet3.user.birthday_date).to eq('20-03-1997')
      expect(ewallet3.user.city).to eq('Gdansk')
    end

    it 'expect to start account with no money on it' do
    end
  end
end
