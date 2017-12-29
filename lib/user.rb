# User class
class User
  attr_accessor :id, :login, :first_name, :last_name, :pesel, :birthday

  def initialize(id, login, first_name, last_name, pesel, birthday)
    @id = id
    @login = login
    @first_name = first_name
    @last_name = last_name
    unless pesel_is_valid(pesel)
      raise ArgumentError, "Pesel is invalid"
    end
    @pesel = pesel

    unless is_old_enough(birthday)
      raise ArgumentError, "User is too young"
    end
    @birthday = birthday
  end

  def pesel_is_valid(pesel)
  end

  def is_old_enough(birthday)
  end

end
