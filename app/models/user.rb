class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  # -- no longer needed with Devise-JWT ---
  # def encrypted_password
  #  return passwd_hash
  # end
  #
  # def encrypted_password= value
  #  return passwd_hash
  # end
end
