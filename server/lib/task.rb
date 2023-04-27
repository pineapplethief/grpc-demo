# frozen_string_literal: true

class Task < Sequel::Model(:tasks)
  def self.build_grpc_task(task)
    ::Tasks::Task.new(
      id: task.id,
      title: task.title,
      description: task.description,
      done_at: task.done_at
    )
  end
end
