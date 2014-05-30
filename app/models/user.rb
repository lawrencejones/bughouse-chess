class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
  			format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { case_sensitive: false}
  has_secure_password
  before_save { email.downcase! }
  validates :password, length: { minimum: 6 }
  has_attached_file :avatar, :styles => {:thumb => "100x100>"}, 
  :default_url => ActionController::Base.helpers.asset_path('default_user_img_lightblue_bg.jpg')
  validates_attachment_content_type :avatar, 
                  :content_type => /\Aimage\/.*\Z/,
                  :size => { :in => 0..64.kilobytes }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(query)
    where("name like ?", "%#{query}%") 
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end