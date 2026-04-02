class User < ApplicationRecord
  has_many :profile_fields, dependent: :destroy
  accepts_nested_attributes_for :profile_fields, allow_destroy: true
  has_many :posts
  has_one_attached :avatar
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

         def self.from_omniauth(auth)
          user = User.where(email: auth.info.email).first_or_initialize
        
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
        
          user.save
          user
        end
        
        def super_admin?
          role == "super_admin"
        end

        def user?
          role == "user"
        end

end
