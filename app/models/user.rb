class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
  			format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  before_save { email.downcase! }
  validates :password, length: { minimum: 6 }

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(query)
    where("name like ?", "%#{query}%") 
  end
  
  def create_unique_token
   self.password_reset_token = loop do
      any_token = User.new_token
      break any_token unless User.exists?(password_reset_token: any_token)
    end
  end
  
  def send_reset_email
    update_attribute(:password_reset_token, create_unique_token)
    update_attribute(:password_reset_sent_at, Time.zone.now)
    UserMailer.send_password_reset_email(self).deliver
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_token)
    end
    
end