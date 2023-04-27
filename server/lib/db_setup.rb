# frozen_string_literal: true

require 'sequel'
require 'logger'

DB = Sequel.sqlite('/tmp/grpc-demo.db', logger: Logger.new(STDOUT))

unless DB.table_exists?(:tasks)
  DB.create_table :tasks do
    primary_key :id

    String :title, null: false
    String :description

    DateTime :done_at

    DateTime :created_at
    DateTime :updated_at
  end
end

Sequel::Model.plugin :timestamps
