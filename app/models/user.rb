class User < ActiveRecord::Base

  has_many :items

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :locality, presence: true
  geocoded_by :location
  after_validation :geocode 
  

#  validates :formatted_address, presence: true
#  validates :country, presence: true

	def self.from_omniauth(auth)
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    		user.email = auth.info.email
    		user.password = Devise.friendly_token[0,20]
    		#user.name = auth.info.name   # assuming the user model has a name
    		#user.image = auth.info.image # assuming the user model has an image
  		end
	end

#This code below gets around Devise being weird about not letting users saving without entering passwords
  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if params[:password].blank? || valid_password?(current_password)
      update_attributes(params, *options)
    else
      self.assign_attributes(params, *options)
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end


  def search_card
    if self.avatar.medium.url
      avatar=self.avatar.medium.url
      return '<a href="/users/'+self.id.to_s+'"><img style="max-width: 50px; max-height: 50px"src='+avatar+'>Lending '+self.items.count.to_s+' items!</a><br>'
    else
      return '<a href="/users/'+self.id.to_s+'">Lending '+self.items.count.to_s+' items!</a><br>'
    end
  end

  acts_as_messageable

  def full_name
  if first_name.present?
    [*first_name.capitalize, last_name.capitalize].join(" ")
  else 
    test full name
  end    
end

  def mailboxer_name
    self.full_name
  end

  def mailboxer_email(object)
    self.email
  end

end

