require 'yaml'
p YAML.load(File.read(File.join(File.dirname(__FILE__),'app','routes.yml')))
#YAML.load カッコ内の文字列をyml形式に変換。 ymlファイルを読み込む時に使う
#Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each {|file| require file }
p Dir[(File.join(File.dirname(__FILE__),'app','controllers','*'))]
a=File.read("./text.rb")
p a.split("\n")