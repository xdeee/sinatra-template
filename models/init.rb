require "sequel"
DB = Sequel.connect("sqlite://#{Dir.pwd}/db.sqlite")

Sequel.extension :migration
Sequel::Migrator.check_current(DB, "#{Dir.pwd}/migration/")

require_all(__FILE__)

configure :development do
end

configure :production do
end
