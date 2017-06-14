class CreatePracticeSchedules < ActiveRecord::Migration
  def change
    create_table :practice_schedules do |t|
      t.date :practice_date, :null => false
      t.time :practice_time, :null => false
      t.integer :fp_count, :default => 0
      t.integer :gk_count, :default => 0
      t.string :place, limt: 255
      t.text :remarks

      t.timestamps null: false
    end
  end
end
