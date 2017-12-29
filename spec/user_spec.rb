require 'spec_helper'
require_relative '../lib/user'

describe User do
  context '#initialize' do
    let(:id) {1}
    let(:first_name) {"Joe"}
    let(:last_name) {"Doe"}
    let(:login) {"joedoe"}
    let(:wrong_pesel) {1212121212}
    let(:correct_pesel) {12121212121}
    let(:wrong_birthday) {10-10-2000}
    let(:correct_birthday) {12-12-1995}

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
end
