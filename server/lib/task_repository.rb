# frozen_string_literal: true

require 'singleton'

class TaskRepository
  include ::Singleton

  NotFound = Class.new(StandardError)

  def list
    Task.order(Sequel.desc(:done_at, nulls: :first))
  end

  def add(grpc_task)
    Task.create(title: grpc_task.title, description: grpc_task.description)
  end

  def delete(id)
    task = Task[id]
    task.delete
  end

  def finish(id)
    task = Task[id]
    raise NotFound unless task

    task.done_at = DateTime.now
    task.save
    task
  end
end
