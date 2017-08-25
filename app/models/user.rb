class User < ActiveRecord::Base
  include BCrypt
  validates :email, :username, presence: true, uniqueness: true
  validate :password_present

  has_many :decks

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(password)
    @password = Password.create(password)
    self.hashed_password = @password
  end

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    return user if user && user.password == password
  end

  private
  def password_present
    errors.add(:password, "cannot be blank") if self.password == ""
  end
end
