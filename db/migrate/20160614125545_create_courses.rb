class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :content
      t.string :description
      t.time :times

      t.timestamps null: false
    end
  end
end
