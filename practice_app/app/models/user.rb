class User < ActiveRecord::Base
  include PublicActivity::Common
  
  has_and_belongs_to_many :events
  attr_accessible :email, :first_name, :last_name, :full_name, :password, :password_confirmation, :avatar_url, :role, :token
  has_secure_password
  # Associations
  has_many :relationships
  has_many :relations, :through => :relationships
  has_many :inverse_relationships, :class_name => "Relationship", :foreign_key => "relation_id"
  has_many :inverse_relations, :through => :inverse_relationships, :source => :user
  has_many :comments, as: :commentable

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  # Gems
  acts_as_commentable
  acts_as_reader
  # Validations
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/
  validates_presence_of :password, :on => :create
  validate :user_token_exists?
  # Filters
  before_save :create_user_token
  # before_create :user_token_exists?
  before_create { generate_token(:auth_token) }
  # Embedded associations
  ROLES = %w[admin parent student tutor]

  def role_symbols
    [role.to_sym]
  end

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

  def create_user_token
    begin
      self.token=SecureRandom.urlsafe_base64
    end while self.class.exists?(token: token)
  end

  def user_token_exists?
    errors.add(:base, 'Invalid user token') unless User.where(token: token).any?
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

  def unreads
    Event.unread_by(self) + Relationship.unread_by(self) + Comment.unread_by(self)
  end

end
