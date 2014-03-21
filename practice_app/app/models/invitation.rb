class Invitation < ActiveRecord::Base
  attr_accessible :invitation, :new, :recipient_email, :sender_id, :sent_at, :token

  validates_presence_of :recipient_email
  validate :recipient_is_not_registered

  before_create :generate_token

  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  private

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
