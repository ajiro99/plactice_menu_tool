class PracticeMenuSet < ActiveRecord::Base
  belongs_to :practice_schedule
  belongs_to :practice_content

  validates :time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :practice_content_id, presence: true
end
