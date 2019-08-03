require "active_record"

 ActiveRecord::Base.establish_connection({
  database: "snipers",
  adapter:  "postgresql",
  encoding: "unicode",
  username: "sniper",
  password: "pwd",
  host: "snipers-db"
})
