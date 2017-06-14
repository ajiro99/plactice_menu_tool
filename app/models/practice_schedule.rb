class PracticeSchedule < ActiveRecord::Base
  has_many :practice_menu_sets, dependent: :destroy
  validates :practice_date, presence: true
  validates :practice_time, presence: true
  validates :fp_count, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :gk_count, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :place, length: { maximum: 255 }
  validates :remarks, length: { maximum: 255 }
end
