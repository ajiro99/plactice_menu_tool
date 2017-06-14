class ChangeDatatypePracticeDateOfPracticeSchedules < ActiveRecord::Migration
  def change
  	change_column :practice_schedules, :practice_date, :datetime
  end
end
