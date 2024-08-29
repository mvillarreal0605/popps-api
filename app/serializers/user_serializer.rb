#--------------
#  This is used by Devise
#--------------
class UserSerializer
  include JSONAPI::Serializer

  attributes :user_id_code, :first_name, :last_name, :nick_name, :email, :cell_number, 
    :passwd_hash, :pin, :age_at_signup, :date_of_signup, :admin_flg, :created_at, :updated_at 

end
