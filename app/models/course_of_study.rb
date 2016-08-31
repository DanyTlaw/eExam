class CourseOfStudy < ApplicationRecord
  # relationship
  has_many :courses
  # imprtanted for nested attributes in the admin panel
  accepts_nested_attributes_for :courses

end
