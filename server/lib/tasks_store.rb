# frozen_string_literal: true

class TasksStore
  def self.tasks
    @tasks ||= {}
  end

  def self.add(task)
    tasks[task.title] = task
  end

  def self.delete(title)
    tasks.delete(title)
  end

  def self.fetch_task(title)
    tasks[title]
  end
end
