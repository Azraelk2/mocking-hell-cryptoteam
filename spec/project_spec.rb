require 'spec_helper'
require_relative '../lib/project'

describe Project do
  context '#add_money(user, ammount)' do
    let(:creator) do
      double('First User', full_name: 'Joe Doe', \
                             pesel: 123_456_789, \
                             birthday_date: '20-03-1997', city: 'Gdansk')
    end
    let(:ammount) { 100.00 }

    subject(:project) { Project.new(1, creator, "Test desc", "Test title", "1000", "2017-12-30 22:42:26 +0100") }

    it 'Expect add_money to change only the value of balance' do
      expect { project.add_money(creator,ammount) }.to change { project.money_backed }
    end

    it 'Expect new value of backe level to be raised by given ammount' do
      expect { project.add_money(creator,ammount) }.to change { project.money_backed }.from(0).to(ammount)
    end
  end
end
