class CreateCourseModules < ActiveRecord::Migration
  def change
    create_table :course_modules do |t|
      t.string :title
      t.boolean :complete

      t.timestamps null: false
    end
  end
end
