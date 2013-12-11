class User < ActiveRecord::Base
  attr_accessible :business_description, :business_name, :city, :email, :name,
  :phone_number, :session, :password

  validates :password, length: {minimum: 6}
  validates_presence_of :password, :email, :name


  def self.find_by_credentials(email, password)
    @user = User.find_by_email(email)
    return @user if !@user.nil? && @user.is_password?(password)
    nil
  end



  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password || self.password_digest
  end

  def reset_token
    self.session = generate_token
    self.save!
    self.session
  end

  def generate_token
    SecureRandom.urlsafe_base64(16)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end


end
