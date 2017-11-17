class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:foursquare]

  def self.find_for_foursquare_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      binding.pry
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.email.first_name
      user.last_name = auth.info.email.last_name
    end
  end
end
