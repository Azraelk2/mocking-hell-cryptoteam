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

    it 'returns E-Wallet type' do
      allow(ewallet1).to receive(:kind_of?).and_return(Ewallet)
      expect(ewallet2).to be_a_kind_of(Ewallet)
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

  context '.money_error(ammount)' do
    it 'raise error when passed ammount is invalid' do
      allow(Ewallet).to receive(:money_error).and_call_original

      expect { Ewallet.money_error(220.25) }.not_to raise_error
      expect { Ewallet.money_error(-200.50) }.to raise_error
      expect { Ewallet.money_error('100') }.to raise_error
      expect { Ewallet.money_error('number') }.to raise_error
    end

    it 'return true if ammount is valid' do
      allow(Ewallet).to receive(:money_error).and_call_original

      expect(Ewallet.money_error(220.25)).to eq(true)
      expect(Ewallet.money_error(1000)).to eq(true)
    end
  end

  context '.balance_error(ammount)' do
    it 'raise error when passed ammount is invalid' do
      allow(Ewallet).to receive(:balance_error).and_call_original
      Ewallet.instance_variable_set(:@balance, 300)

      expect { Ewallet.balance_error(220.25) }.not_to raise_error
      expect { Ewallet.balance_error(2000) }.to raise_error
      expect { Ewallet.balance_error(400.67) }.to raise_error
    end

    it 'return true if ammount is valid' do
      allow(Ewallet).to receive(:balance_error).and_call_original
      Ewallet.instance_variable_set(:@balance, 300)

      expect(Ewallet.itself.balance_error(220.25)).to eq(true)
      expect(Ewallet.itself.balance_error(10)).to eq(true)
    end
  end

  context '#deposit_money(ammount)' do
    let(:id) { 1 }
    let(:user) { double('Some user') }
    let(:name) { 'My first e-wallet' }
    subject(:ewallet) { Ewallet.new(id, user, name) }
    let(:ammount) { 100.00 }
    let(:first_deposit) { ewallet.deposit_money(ammount) }
    let(:next_deposit) do
      ewallet.balance = ammount
      ewallet.deposit_money(ammount)
    end

    it 'expect not to raise error if ammount is positive numeric' do
      expect { ewallet.deposit_money(100) }.not_to raise_error
      expect { ewallet.deposit_money(120.89) }.not_to raise_error
      expect { ewallet.deposit_money(-200.50) }.to raise_error
      expect { ewallet.deposit_money('100') }.to raise_error
      expect { ewallet.deposit_money('number') }.to raise_error
    end

    it 'expect deposit_money to change only the value of balance' do
      expect { first_deposit }.to change { ewallet.balance }.from(0)
      expect { first_deposit }.not_to change { ewallet.user }.from(ewallet.user)
      expect { first_deposit }.not_to change { ewallet.id }.from(ewallet.id)
      expect { first_deposit }.not_to change { ewallet.name }.from(ewallet.name)
    end

    it 'expect new value of balance to be raised by given ammount' do
      expect { first_deposit }.to change { ewallet.balance }.from(0).to(ammount)
      expect { next_deposit }.to change { ewallet.balance }.from(100).to(200)
    end
  end

  context '#withdraw_money(ammout)' do
    let(:id) { 1 }
    let(:user) { double('Some user') }
    let(:name) { 'My first e-wallet' }
    subject(:ewallet) { Ewallet.new(id, user, name) }
    let(:ammount) { 100.00 }
    let(:deposit) { ewallet.deposit_money(ammount) }
    let(:withdraw) { ewallet.withdraw_money(ammount) }
    let(:withdraw_two) { ewallet.withdraw_money(ammount) }
    let(:withdraw_three) { ewallet.withdraw_money(ammount) }
    let(:small_withdraw) { ewallet.withdraw_money(25.25) }

    it 'expect withdraw to change balance if ammount is a positive numeric' do
      allow(Ewallet).to receive(:money_error).and_return(true, true, false)
      allow(Ewallet).to receive(:balance_error).and_return(true)
      ewallet.balance = 1000.00

      expect { ewallet.withdraw_money(100) }.to change \
             { ewallet.balance }.from(ewallet.balance)
      expect { ewallet.withdraw_money(120.89) }.to change \
             { ewallet.balance }.from(ewallet.balance)
      expect { ewallet.withdraw_money(-20) }.not_to change \
             { ewallet.balance }.from(ewallet.balance)
      expect { ewallet.withdraw_money('100') }.not_to change \
             { ewallet.balance }.from(ewallet.balance)
      expect { ewallet.withdraw_money('number') }.not_to change \
             { ewallet.balance }.from(ewallet.balance)
    end

    it 'expect withdraw_money to change only the value of balance' do
      allow(Ewallet).to receive(:money_error).and_return(true)
      allow(Ewallet).to receive(:balance_error).and_return(true)
      ewallet.balance = 1000.00

      expect { withdraw }.to change { ewallet.balance }.from(1000.00)
      expect { withdraw }.not_to change { ewallet.user }.from(ewallet.user)
      expect { withdraw }.not_to change { ewallet.id }.from(ewallet.id)
      expect { withdraw }.not_to change { ewallet.name }.from(ewallet.name)
    end

    it 'expect new value of balance to decrease by given ammount' do
      allow(Ewallet).to receive(:money_error).and_return(true)
      allow(Ewallet).to receive(:balance_error).and_return(true)
      ewallet.balance = 800.00

      expect do
        withdraw
        withdraw_two
      end.to change { ewallet.balance }.from(800).to(600)

      expect { withdraw_three }.to change { ewallet.balance }.from(600).to(500)
    end

    it 'can not withdraw money if ammout is bigger than balance' do
      allow(Ewallet).to receive(:money_error).and_return(true, true)
      allow(Ewallet).to receive(:balance_error).and_return(false, true)
      ewallet.balance = 50.00

      expect { withdraw }.not_to change { ewallet.balance }.from(50.00)
      expect { small_withdraw }.to change { ewallet.balance }.from(50.00)
    end
  end
end
