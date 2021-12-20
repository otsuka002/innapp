class Room < ApplicationRecord
    belongs_to :user
    has_many :reservations
    has_one_attached :room_image
    def self.search(keyword)
      where(["address like? OR room_name like?", "%#{keyword}%", "%#{keyword}%"])
    end
end
