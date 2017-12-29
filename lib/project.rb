# Project class which allows users to collect money for different things
module ProjectStatus
  ENDED = "Ended"
  RUNNING = "Running"
  BACKED = "Backed"
end

Transaction = Struct.new(:user, :ammount)

class Project
  attr_accessor :id, :creator, :description, :title, :money_required, :money_backed, :status, :date_created, :due_date, :date_backed

  def initialize(id, creator, description, title, money_required, due_date)
    @id = id
    @creator = creator
    @description = description || "#{@title} project created by #{@creator.full_name}"
    @title = title
    @money_required = money_required
    @money_backed = 0.0 # Current ammount of backed money
    @status = ProjectStatus::RUNNING # Whether it's running, backed or ended
    @due_date = due_date
    @date_created = Time.now
    @date_backed = nil # Can be nil because entire project sometimes won't be backed
    @backers = []
  end

  def add_money(user, ammount)
    unless ammount.is_a?(Numeric) && ammount >= 0.0
      raise ArgumentError, "Ammount must be a positive integer"
    end
    @money_backed += ammount
    @backers.push(Transaction.new(user,ammount))
  end

  def check_if_backed()
    if @money_backed >= @money_required.to_f
      true
    else 
      false
    end
  end

  def change_title_to(title)
    unless title.length > 5
      raise ArgumentError, "Title can't be shorter than 5 characters"
    end
    unless title != @title
      raise ArgumentError, "You replace title by itself"
    end
    @title = title
  end

  def change_date_to(date)
    unless date > Time.now
      raise ArgumentError, "Date can't be in the past"
    end
    unless date < @due_date
      raise ArgumentError, "You can't make a project shorter"
    end
    @due_date = date
  end
end