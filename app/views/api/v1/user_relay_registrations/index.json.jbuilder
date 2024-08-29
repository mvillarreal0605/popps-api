json.array! @user_relay_registrations do |urr|
  json.extract! urr, :id, :user_id, :device_guid, :device_description, :usage_count 
end
