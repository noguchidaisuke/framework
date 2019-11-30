require 'sequel'
require 'yaml'

#{"adapter"=>"sqlite", "database"=>"./app/db/development.sqlite3"}
db_config_file=File.join(File.dirname(__FILE__),'app','database.yml')
config=YAML.load(File.read(db_config_file))
DB=Sequel.connect(config)
DB=Sequel::SQLite::Database: {"adapter"=>"sqlite", "database"=>"./app/db/development.sqlite3"}
Sequel.extension :migration
Sequel::Migrator.run(DB,File.join(File.dirname(__FILE__),'app','db','migrations'))
#DB = Sequel.sqlite

DB.create_table :items do
    primary_key :id
    String :name
    Float :price
end

items = DB[:items]

items.insert(:name => 'abc',:price => rand * 100)
items.insert(:name => 'def', :price => rand * 100)
items.insert(:name => 'ghi', :price => rand * 100)

puts "Item count: #{items.count}"

puts "The average price is: #{items.avg(:price)}"