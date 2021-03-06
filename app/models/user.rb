class User < ActiveRecord::Base
  attr_accessible :business_description, :business_name, :city, :email, :name,
  :phone_number, :session, :password

  validates :password, length: {minimum: 6}
  validates_presence_of :password, :email, :name

  geocoded_by :ip_address
  after_validation :geocode


  has_many(:offices,
  class_name: "Office",
  foreign_key: :owner_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:in_deals,
  class_name: "Deal",
  foreign_key: :owner_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:out_deals,
  class_name: "Deal",
  foreign_key: :renter_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:favorites,
  class_name: "Favorite",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:sent_messages,
  class_name: "Message",
  foreign_key: :sender_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(:received_messages,
  class_name: "Message",
  foreign_key: :receiver_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many :favorite_offices, through: :favorites, source: :office


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

  def deals
    in_deals + out_deals
  end


end
