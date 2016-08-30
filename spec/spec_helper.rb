require "active_record"
require "retryable_find_or_create_by"

# ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

class User < ActiveRecord::Base; end

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name, null: false
    t.index  :name, unique: true
  end
end

RSpec.configure do |config|
end
