class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :omniauthable, omniauth_providers: [:github, :google_oauth2, :facebook]



  has_many :posts, through: :roles, source: :resource, source_type: :Post
  has_many :creator_posts, -> { where(roles: {name: :creator}) }, through: :roles, source: :resource, source_type: :Post
  has_many :editor_posts, -> { where(roles: {name: :editor}) }, through: :roles, source: :resource, source_type: :Post
  
  after_create :assign_default_role

  validate :must_have_a_role, on: :update
  validates :image, length: { maximum: 500 }
  
  private

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  private

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, 'must have at least 1 role')
    end
  end

  private

  def send_mail
    UserMailer.welcome_email(current_user).deliver_now
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session["devise.facebook_data"] &&
        session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first
  #   unless user
  #     user = User.create(
  #     email:data['email'],
  #     password: Devise.friendly_token[0,20]
  #     )
  #   end
  #   user
  # end

  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    if result
      return result
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.fullname = auth.info.name
        user.image = auth.info.image
        user.uid = auth.uid
        user.provider = auth.provider

        #  If you are using confirmable and the provider(s) you use validate emails
        user.skip_confirmation!
      end
    end
  end

end
