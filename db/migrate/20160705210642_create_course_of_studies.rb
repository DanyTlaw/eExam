class CreateCourseOfStudies < ActiveRecord::Migration[5.0]
  def change
    create_table :course_of_studies do |t|

      t.string :name
      t.string :semester
      
      t.timestamps
    end
  end
end
