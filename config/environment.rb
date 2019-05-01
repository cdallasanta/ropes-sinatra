require 'bundler/setup'
Bundler.require

ENV["session_secret"] = "a18781ca9f7ae4e32be3339cce54f0364ea5d6029ea53e7309d2cc1dc55586a7558067a0e0a503ef08154a32b15
c29a26fe5c0c3b707c3e2aca669fcc23e1a64"

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/log-development.db"
)

require_all 'app'
