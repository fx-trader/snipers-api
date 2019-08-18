require_relative "models"

 ActiveRecord::Schema.define do

  native_database_types.merge!(
    datetime:  { name: "timestamptz" },
    timestamp: { name: "timestamptz" }
  )

  create_table :accounts, force: :cascade do |t|
    t.string  :email, :null => false, unique: true
    t.boolean :uses_time_restrictions, :null => false, :default => true
  end
  add_index :accounts, :email, unique: true
  Account.create :email => 'joaocosta@zonalivre.org'

  create_table :snipers, force: :cascade do |t|
    t.integer :account_id,  :null => false, :references => [:accounts, :id]
    t.string  :instrument,  :null => false
    t.string  :timeframe,   :null => false
    t.string  :expression,  :null => false
    t.integer :quantity,    :null => false
  end
  add_foreign_key :snipers, :accounts

  create_table :economic_calendars, force: :cascade do |t|
    t.datetime :start, :null => false
    t.string   :description, :null => false, :default => ''
  end
  add_index :economic_calendars, :start

end
