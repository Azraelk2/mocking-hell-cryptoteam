require 'spec_helper'
require 'date'
require_relative '../lib/user'

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

  context '.pesel_is_valid(pesel)' do
    let(:pesel_right) { 12121212121 }
    let(:pesel_wrong) { 1212121212122 }

    it 'Expect proper validation if user provided legit pesel' do
      allow(User).to receive(:pesel_is_valid).and_call_original
      expect(User.itself.pesel_is_valid(pesel_right)).to eq(true) # wpisz sobie false i zobacz
      expect(User.itself.pesel_is_valid(pesel_wrong)).to eq(false)
    end
  end

  context '.is_old_enough(birthday)' do
    it 'Expect proper validation if user is at least 18 years old' do
      allow(User).to receive(:is_old_enough).and_call_original
      expect(User.is_old_enough(Date.civil(2000,1,1))).to eq(false)
      expect(User.is_old_enough(Date.civil(2006,1,1))).to eq(false)
      expect(User.is_old_enough(Date.civil(1994,1,1))).to eq(true)
    end
  end
end
