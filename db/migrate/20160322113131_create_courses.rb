class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :provider
      t.string :name
      t.string :description
      t.string :organisation
      t.string :image
      t.string :url
      t.string :duration
      t.datetime :startdate
      t.datetime :enddate

      t.timestamps null: false
    end
  end
end
