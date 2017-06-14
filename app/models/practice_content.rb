class PracticeContent < ActiveRecord::Base
  belongs_to :category
  has_many :practice_menu_sets, dependent: :destroy
  
  validates :category, presence: true
  validates :practice_name, presence: true, length: { maximum: 255 }
  validates :head_count, length: { maximum: 255 }
  validates :estimated_time, length: { maximum: 255 }
  validates :strength, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/, :allow_blank => true
end
