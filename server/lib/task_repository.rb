# frozen_string_literal: true

require 'singleton'

class TaskRepository
  include ::Singleton

  NotFound = Class.new(StandardError)

  def tasks
    @tasks ||= {}
  end

  def list
    tasks.values.sort_by { |task| task.done_at.nil? || task.done_at }
  end

  def add(task)
    tasks[task.title] = task
  end

  def delete_by_title(title)
    tasks.delete(title)
  end

  def finish_by_title(title)
    task = tasks[title]
    raise NotFound unless task

    tasks[title] = Task.new(title: task.title, description: task.description, done_at: DateTime.now)
    tasks[title]
  end
end
