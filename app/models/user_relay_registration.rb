class UserRelayRegistration < ApplicationRecord
  belongs_to :user
  validates :device_guid,  uniqueness: { scope: :user_id_code}
end
