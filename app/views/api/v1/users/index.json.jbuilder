json.array! @users do |user|
  json.extract! user, :id, :user_id, :first_name, :last_name, :nick_name, :email, :cell_number, :pin, :age_at_signup, :date_of_signup, :admin_flg
end
