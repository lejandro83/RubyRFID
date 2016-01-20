require 'active_record'
require 'sqlite3'

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :dbfile  => ":memory:",
  :database => "RFID"
)

unless ActiveRecord::Base.connection.tables.include? 'cards'
  ActiveRecord::Schema.define do
    create_table :cards do |table|
      table.column :card_id, :string
      table.column :user_name, :string
      table.column :balance, :int
    end
  end
end

class Card < ActiveRecord::Base
end
