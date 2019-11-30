=begin
require 'yaml'
ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), 'app', 'routes.yml')))
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each{ |file| require file }
Dir[File.join(File.dirname(__FILE__), 'app', '**','*.rb')].each{ |file| require file }
require './lib/router'

db_config_file = File.join(File.dirname(__FILE__), 'app', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), 'app', 'db', 'migrations'))
end
=end
require 'sequel'
require 'yaml'

db_config_file=File.join(File.dirname(__FILE__),'app','database.yml')
if File.exist?(db_config_file)
  config=YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each{ |file| require file }

if DB
  Sequel::Migrator.run(DB,File.join(File.dirname(__FILE__),'app','db','migrations'))
end

Dir[File.join(File.dirname(__FILE__), 'app', '**','*.rb')].each{ |file| require file }
ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), 'app', 'routes.yml')))
#ハッシュ
require './lib/router'

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end
  def self.root
    File.dirname(__FILE__)
  end
  def call(env)
    result = router.resolve(env)
    #[200,{},['Hello World']]
    [result.status, result.headers, result.content]
  end
end
#appでrequireすればいいのか
#callにstatus header content入れたい
#envからpathを取り出す
#routes.ymlをYAMLをハッシュにして引数にとる
#配列をインスタンス変数に入れてresolveでpath取り出す
#取り出したpathがroutes.ymlのvにあるのか
#vをsplitしてcontrollerめいとメソッドにわける
#const_getでインスタンス作る