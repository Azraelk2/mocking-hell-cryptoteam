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

    it 'Expect not to raise error if ammount is positive numeric' do
      expect { project.add_money(creator,-100) }.to raise_error
      expect { project.add_money(creator,ammount) }.not_to raise_error
    end
  end

  context '#check_if_backed()' do
    let(:creator) do
      double('First User', full_name: 'Joe Doe', \
                             pesel: 123_456_789, \
                             birthday_date: '20-03-1997', city: 'Gdansk')
    end
    subject(:project1) { Project.new(1, creator, "Test desc", "Test title", "1000", "2017-12-30 22:42:26 +0100") }
    subject(:project2) { Project.new(2, creator, "Test desc", "Test title", "10000", "2017-12-30 22:42:26 +0100") }

    it 'Expect project to be backed if ammount is sufficient' do
      project1.add_money(creator,1000)
      project2.add_money(creator,10)
      expect(project1.check_if_backed).to be true
      expect(project2.check_if_backed).to be false
    end
  end
end
