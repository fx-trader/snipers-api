require_relative "connection"

 ActiveRecord::Schema.define do
  create_table :snipers, force: :cascade do |t|
    t.string  :instrument
    t.string  :timeframe
    t.string  :expression
    t.integer :quantity
    t.string  :state
  end
end
