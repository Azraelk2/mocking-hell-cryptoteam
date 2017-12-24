# E-wallet that belongs to user of service
class Ewallet
  attr_accessor :id, :user, :name, :balance

  def initialize(id, user, name)
    @id = id
    @user = user
    @name = name || "#{@user.full_name}'s e-wallet"
    @balance = 0.0
  end
end
