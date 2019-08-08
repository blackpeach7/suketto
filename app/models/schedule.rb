class Schedule < ApplicationRecord
  validates :place, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validate :schedule_cannot_be_in_the_future
  
def schedule_cannot_be_in_the_future
  if schedule.present? && schedule > Date.today
    errors.add(:schedule, "can not specify your future date as your schedule date.")
  end
end


  belongs_to :user
end
