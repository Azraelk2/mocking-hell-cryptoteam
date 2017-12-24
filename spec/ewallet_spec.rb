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
      double('Another user', full_name: 'Gruby Wojt', \
                             pesel: 123_456_789, \
                             birthday_date: '20-03-1997', city: 'Gdansk')
    end

    subject(:ewallet1) { Ewallet.new(id, user1, nil) }
    subject(:ewallet2) { Ewallet.new(id, user2, 'My wallet') }
    subject(:ewallet3) { Ewallet.new(id, user3, 'Na Wódeczkę') }

    it 'creates a new e-wallet correctly' do
      expect { ewallet1 }.not_to raise_error
      expect { ewallet2 }.not_to raise_error
      expect { ewallet3 }.not_to raise_error
    end

    it 'returns correct id of e-wallet' do
      expect(ewallet1.id).to eq(id)
    end

    it "should be named after user if name isn't set" do
      expect(ewallet1.name).to eq("#{name_rand}'s e-wallet")
      expect(ewallet2.name).to eq('My wallet')
    end

    it 'e-wallet data is inherited from user and of correct type' do
      expect(ewallet3.id).to be_a(Integer)
      expect(ewallet3.user.full_name).to be_a(String).and include('Gruby Wojt')
      expect(ewallet3.user.pesel).to be_a(Integer).and eq(123_456_789)
      expect(ewallet3.user.birthday_date).to be_a(String)
      expect(ewallet3.user.birthday_date).to include('20-03-1997')
      expect(ewallet3.user.city).to be_a(String).and include('Gdansk')
    end

    it 'expect to start e-wallet with no money in it' do
      expect(ewallet1.balance).to eq(0)
      expect(ewallet2.balance).to eq(0)
      expect(ewallet3.balance).to eq(0)
    end
  end

  context '#deposit_money' do
  end
end
