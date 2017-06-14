class CreatePracticeMenuSets < ActiveRecord::Migration
  def change
    create_table :practice_menu_sets do |t|
      t.references :practice_schedule, index: true, foreign_key: true, :null => false
      t.references :practice_content, index: true, foreign_key: true, :null => false
      t.integer :order, :null => false
      t.integer :time, :null => false

      t.timestamps null: false
    end
  end
end
