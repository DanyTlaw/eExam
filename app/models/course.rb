class Course < ApplicationRecord
  belongs_to :course_of_study
  has_many :students
end
