class Category < ActiveRecord::Base
	has_many :practice_contents, dependent: :destroy
    validates :name, presence: true, length: { maximum: 255 }
end
