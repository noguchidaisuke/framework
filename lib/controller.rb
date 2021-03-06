class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action
  end

  def call
    send(action)
    #文字列をシンボルにして引数にとる、200の場合titlearr入れる
    self.status = 200
    self.headers = {"Content-Type" => "text/html"}
    self.content = [template.render(self)]
    self
  end
  def template
    Slim::Template.new(File.join(App.root,'app','views',"#{self.name}","#{self.action}.slim"))
  end
  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Nothing found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal error"]
    self
  end
end

#200が帰ってきた時って話かな
#attributeはクラスのメソッドになってるわけやから