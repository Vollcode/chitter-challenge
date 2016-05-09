class Peep
  include DataMapper::Resource

  property :id,         Serial
  property :title,      String
  property :content,    String
  property :time,       String

  belongs_to :user
end
