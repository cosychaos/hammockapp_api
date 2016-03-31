class AddCourseIdToCourseModules < ActiveRecord::Migration
  def change
    add_reference :course_modules, :course, index: true, foreign_key: true
  end
end
