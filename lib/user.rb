# User class
require 'date'

class User
  attr_accessor :id, :login, :first_name, :last_name, :pesel, :birthday

  def initialize(id, login, first_name, last_name, pesel, birthday)
    @id = id
    @login = login
    @first_name = first_name
    @last_name = last_name
    unless User.pesel_is_valid(pesel)
      raise ArgumentError, "Pesel is invalid"
    end
    @pesel = pesel
    unless User.is_old_enough(birthday)
      raise ArgumentError, "User is too young"
    end
    @birthday = birthday
  end

  def self.pesel_is_valid(pesel)
    if (pesel.to_s).length != 11
      return false
    else
      return true
    end
  end

  def self.is_old_enough(birthday)
    unless ((Date.today - birthday)/365.25).to_i > 18
      return false
    end
    return true
  end
end
