# frozen_string_literal: true

require 'dry-struct'

module Types
  include Dry.Types()
end

class Task < Dry::Struct
  attribute :title, Types::String
  attribute :description, Types::String.optional
  attribute? :done_at, Types::DateTime.optional

  def self.build_from_grpc_task(grpc_task)
    new(
      title: grpc_task.title,
      description: grpc_task.description,
      done_at: grpc_task.done_at
    )
  end

  def self.build_grpc_task(task)
    done_at_timestamp = unless task.done_at.nil?
      Google::Protobuf::Timestamp.new(seconds: Time.parse(task.done_at.to_s).to_i)
    end

    ::Tasks::Task.new(
      title: task.title,
      description: task.description,
      done_at: done_at_timestamp
    )
  end
end

class TasksList
  attr_reader :tasks

  def initialize(tasks)
    @tasks = tasks
  end

  def each
    return enum_for(:each) unless block_given?

    tasks.each { |task| yield ::Task.build_grpc_task(task) }
  end
end
