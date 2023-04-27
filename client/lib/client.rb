# frozen_string_literal: true

require 'singleton'

class Client
  include Singleton

  HOSTNAME = 'localhost:33377'

  def get_tasks
    request = ::Tasks::GetTasksRequest.new

    with_error_handling do
      stub.get_tasks(request)
    end
  end

  def add_task(title:, description:)
    task = ::Tasks::Task.new(title: title, description: description)

    request = ::Tasks::AddTaskRequest.new(task: task)

    with_error_handling do
      stub.add_task(request)
    end
  end

  def finish_task(title:)
    request = ::Tasks::FinishTaskRequest.new(title: title)

    with_error_handling do
      stub.finish_task(request)
    end
  end

  def delete_task(title:)
    request = ::Tasks::DeleteTaskRequest.new(title: title)

    with_error_handling do
      stub.delete_task(request)
    end
  end

  private

  def stub
    @stub = Tasks::TasksService::Stub.new(HOSTNAME, :this_channel_is_insecure)
  end

  def with_error_handling
    yield
  rescue GRPC::BadStatus => e
    abort "GRPC ERROR: #{e.message}"
  end
end
