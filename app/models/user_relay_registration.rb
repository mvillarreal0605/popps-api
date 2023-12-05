class UserRelayRegistration < ApplicationRecord
  validates :device_guid,  uniqueness: { scope: :user_id}
end
