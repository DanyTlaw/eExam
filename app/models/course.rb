class Course < ApplicationRecord

  # relationships
  belongs_to :course_of_study
  has_many :students
  # important for the nested attributes in the adminpanel
  accepts_nested_attributes_for :students
end
