require 'sequel'

class Tasks

  attr_reader :new_task_id

  def initialize(db)
    @db = db
    @tasks = @db[:tasks]
  end

  def create(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @new_task_id = @tasks.insert(title: @title, description: @description)
  end

end