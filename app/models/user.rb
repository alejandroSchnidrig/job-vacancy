require 'digest/md5'
require 'strong_password'

#require "dm-core"
#require "dm-validations"
#require "dm-accepts_nested_attributes"

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  property :company, String
  property :code, String

   has n, :job_offers
  #accepts_nested_attributes_for :job_offers


 # has n, :job_offers
 # accepts_nested_attributes_for :job_offers

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email, :with => :email_address

  def password= (password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?	
  end

  def generate_code
    code = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join
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
    is_valid_pass(password) and checker.is_strong?(min_entropy: 16)
  end

  def getGravatarImgAddress
    return 'https://www.gravatar.com/avatar/'  + Digest::MD5.hexdigest(email) + '?s=30'
  end

def is_valid_pass(password)
  if (password =~ /[A-Z]/ ) and (password =~ /[a-z]/ ) and (password =~ /[0-9]/ ) and (password.length > 8)
    true
  else
    false
  end
end

end
