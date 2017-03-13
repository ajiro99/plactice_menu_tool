class CreatePracticeContents < ActiveRecord::Migration
  def change
    create_table :practice_contents do |t|
      t.references :category, index: true, foreign_key: true, :null => false
      t.string :practice_name, limt: 255, :null => false
      t.string :head_count, limt: 255
      t.string :estimated_time, limt: 255
      t.text :content
      t.integer :strength, :default => 0
      t.string :url

      t.timestamps null: false
    end
  end
end
