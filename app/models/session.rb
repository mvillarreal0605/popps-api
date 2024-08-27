class Session < ApplicationRecord

  belongs_to :user
  has_many   :pitches, -> { order(created_at: :asc) }, dependent: :destroy

end
