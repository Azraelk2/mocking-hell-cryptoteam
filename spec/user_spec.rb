require 'spec_helper'
require_relative '../lib/user'
require 'date'

describe User do
  context '#initialize' do
    let(:id) {1}
    let(:first_name) {"Joe"}
    let(:last_name) {"Doe"}
    let(:login) {"joedoe"}
    let(:wrong_pesel) {1212121212}
    let(:correct_pesel) {12121212121}
    let(:wrong_birthday) {Date.civil(2000,1,1)}
    let(:correct_birthday) {Date.civil(1995,1,1)}

    subject(:user1) {User.new(id,login,first_name,last_name,wrong_pesel,correct_birthday)}
    subject(:user2) {User.new(id,login,first_name,last_name,correct_pesel,wrong_birthday)}
    subject(:user3) {User.new(id,login,first_name,last_name,wrong_pesel,wrong_birthday)}
    subject(:user4) {User.new(id,login,first_name,last_name,correct_pesel,correct_birthday)}

    it 'Expect proper behaviour while creating an user' do
      expect{user1}.to raise_error
      expect{user2}.to raise_error
      expect{user3}.to raise_error
      expect{user4}.not_to raise_error
    end
  end

  context '#pesel_is_valid(pesel)' do
    it 'Expect proper validation if user provided legit pesel' do
      #expect(User.pesel_is_valid(1212121212).to be false
      #expect(User.pesel_is_valid(121212121222).to be false
      #expect(User.pesel_is_valid(12121212121).to be true
    end
  end

  context '#is_old_enough(birthday)' do
    it 'Expect proper validation if user is at least 18 years old' do
      #expect(User.is_old_enough(Date.civil(2000,1,1))).to be false
      #expect(User.is_old_enough(Date.civil(2006,1,1))).to be false
      #expect(User.is_old_enough(Date.civil(1994,1,1))).to be true
    end
  end
end
