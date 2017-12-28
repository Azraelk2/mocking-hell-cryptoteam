# Project class which allows users to collect money for different things
class Project
  attr_accessor :id, :creator, :description, :title, :money_required, :status

  def initialize(id, creator, description, title, money_required)
    @id = id
    @creator = creator
    @description = description || "#{@title} project created by #{@creator.full_name}"
    @title = title
    @money_required = money_required
    @money_backed = 0.0
    @status = "Running"
  end
end