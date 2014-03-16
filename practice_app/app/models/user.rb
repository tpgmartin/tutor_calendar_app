class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :full_name, :password, :password_confirmation
  has_secure_password
  has_many :comments, :as => :commentable
  has_many :comments, :as => :commenter
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  before_create { generate_token(:auth_token) }

  def full_name
    [first_name, last_name].join(' ')
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])    
  end

  def send_password_reset
    generate_token(:password_reset_token)    
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end
