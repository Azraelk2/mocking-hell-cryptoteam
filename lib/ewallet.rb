# E-wallet that belongs to user of service
class Ewallet
  attr_accessor :id, :user, :name, :balance

  def initialize(id, user, name)
    @id = id
    @user = user
    @name = name || "#{@user.full_name}'s e-wallet"
    @balance = 0.0
  end

  def self.money_error(ammount)
    raise ArgumentError, 'Ammount must be a positive integer' \
          unless ammount.is_a?(Numeric) && ammount >= 0.0
    true
  end

  def self.balance_error(ammount)
    raise ArgumentError, 'You do not have that much money in wallet' \
          if ammount > @balance
    true
  end

  def deposit_money(ammount)
    @balance += ammount if Ewallet.money_error(ammount)
  end

  def withdraw_money(ammount)
    @balance -= ammount if Ewallet.money_error(ammount) && \
                           Ewallet.balance_error(ammount)
  end
end
