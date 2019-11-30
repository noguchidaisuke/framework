require 'rubygems'
require 'bundler'
Bundler.require

load "./app.rb"
=begin
class App
    def call(env)
        [200,{},['Hello World']]
    end
end
=end

run App.new

#callmethodがある
#callmethodにサーバーからのリクエストを受け取るための引数(env)
#ステータスコード　heada{} body ['内容']