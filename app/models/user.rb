require 'bcrypt'
class User
  attr_reader :password
  attr_accessor :password_confirmation
  include DataMapper::Resource

  property :id,         Serial
  property :username,   String
  property :name,       String
  property :email,      String, required: true, unique: true
  property :password_digest,  String, required: true, unique: true, length: 80

  validates_confirmation_of :password


  has n, :peeps

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(username: username, password_digest: password)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end
end
