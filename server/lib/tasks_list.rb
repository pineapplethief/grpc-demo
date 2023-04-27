# frozen_string_literal: true

class TasksList
  attr_reader :tasks

  def initialize(tasks)
    @tasks = tasks
  end

  def each
    return enum_for(:each) unless block_given?

    tasks.each { |task| sleep 1; yield ::Task.build_grpc_task(task) }
  end
end
