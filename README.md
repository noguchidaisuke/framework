# framework
make my framework

def call(env)
  [ status,{header},[content]
end

routes.ymlにrouting設定
file読み込んでenv["REQUEST_PATH"]に対応するkey探してvalue取りだす
valueをcontroller名とmethodにわけ controllerのオブジェクトに対してメソッドをsendする
インスタンス変数をぶち込む。そのままobjectのstatus 200 header text入れる
最後にcontentにviewの内容をハッシュ化してmain index.slimをcontentに入れる
File.join(App.root,'app','views',"#{self.name}","#{self.action}.slim")でviewのパス
あった場合はstatus header contentぶち込む。

わかったこと
#リクエストにはenv pathやcontent とうの情報が入ってる
#routingは予想されるenvのpathとcontroller名を入れるk-vstore
#controllerはレスポンスcontentのためのインスタンス変数を作る場所
#
