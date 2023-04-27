# frozen_string_literal: true

require 'dry-struct'

module Types
  include Dry.Types()
end

class Task < Dry::Struct
  attribute :title, Types::String
  attribute :description, Types::String.optional
  attribute? :done_at, Types::DateTime.optional
end
