class Session < ApplicationRecord

  belongs_to :user
  has_many   :pitches, -> { order(create_time: :desc) }, dependent: :destroy

end
