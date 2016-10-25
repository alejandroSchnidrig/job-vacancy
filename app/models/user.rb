require 'digest/md5'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  has n, :job_offers

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email,    :with => :email_address

  def password= (password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?	
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.has_password?(password)? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def getGravatarImgAddress
    # return 'https://www.gravatar.com/avatar/' # + Digest::MD5.hexdigest(user.email) 
    # return 'https://www.gravatar.com/avatar/a5ef1ae46ae4e9aa7210a56a4b53a740'
    # return email
    return 'https://www.gravatar.com/avatar/'  + Digest::MD5.hexdigest(email) 
  end


end
