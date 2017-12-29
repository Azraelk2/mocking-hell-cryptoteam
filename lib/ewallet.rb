# E-wallet that belongs to user of service
class Ewallet
  attr_accessor :id, :user, :name, :balance

  def initialize(id, user, name)
    @id = id
    @user = user
    @name = name || "#{@user.full_name}'s e-wallet"
    @balance = 0.0
  end

  def money_error(ammount)
    if ammount.is_a?(Numeric) && ammount >= 0.0
      false
    else
      true
    end
  end

  def deposit_money(ammount)
    raise ArgumentError, 'Ammount must be a positive integer' \
          if money_error(ammount)
    @balance += ammount
  end

  def withdraw_money(ammount)
    raise ArgumentError, 'Ammount must be a positive integer' \
          if money_error(ammount)
  end
end
