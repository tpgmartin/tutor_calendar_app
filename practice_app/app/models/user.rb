class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :full_name, :password, :password_confirmation, :avatar_url
  has_secure_password
  # Associations
  has_many :relationships
  has_many :relations, :through => :relationships
  has_many :inverse_relationships, :class_name => "Relationship", :foreign_key => "relation_id"
  has_many :inverse_relations, :through => :inverse_relationships, :source => :user
  acts_as_commentable
  # Validations
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/
  validates_presence_of :password, :on => :create
  # Filters
  before_create { generate_token(:auth_token) }

  def role?(role)
    self.role.to_s == role.to_s
  end

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
