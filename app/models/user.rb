class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:foursquare]

  has_many :places, dependent: :destroy


  def self.find_for_foursquare_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.access_token = auth.credentials.token
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      image = auth.info.image
      photo_prefix = image.prefix
      photo_suffix = image.suffix
      user.photo = "#{photo_prefix}100x100#{photo_suffix}"
    end
  end
end
