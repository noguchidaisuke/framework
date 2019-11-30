class Post < Sequel::Model(DB)
    plugin :validation_helpers
    def validate
        validates_presence [:content,:title]
        validates_type String, :content
    end
end