require 'digest/md5'
require 'strong_password'

class User
  include DataMapper::Resource
  #include ActiveModel::Validations

  # Basic usage.  Defaults to minimum entropy of 18 and no dictionary checking
  #validates :password, password_strength: true

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  property :company, String
  has n, :job_offers

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email, :with => :email_address

  def password= (password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?	
  end

  def generate_password 
    new_password = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join
  end

  def apply_password
    new_password = self.generate_password
    self.crypted_password = ::BCrypt::Password.create(new_password) unless new_password.nil?  
    return new_password
  end 

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.has_password?(password)? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def verify_password_is_strong(password)
      checker = StrongPassword::StrengthChecker.new(password)
      checker.is_strong?(min_entropy: 16)
  end

  def getGravatarImgAddress
    # return 'https://www.gravatar.com/avatar/' # + Digest::MD5.hexdigest(user.email) 
    # return 'https://www.gravatar.com/avatar/a5ef1ae46ae4e9aa7210a56a4b53a740'
    # return email
    return 'https://www.gravatar.com/avatar/'  + Digest::MD5.hexdigest(email) + '?s=30'
  end


end
