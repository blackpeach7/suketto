class Schedule < ApplicationRecord
  validates :place, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }

  belongs_to :user
end
