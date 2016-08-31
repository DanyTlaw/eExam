class Student < ApplicationRecord
  #relationship
  belongs_to :course
  # declare the uploader for inetarcting with file uploads
  mount_uploader :file, FileUploader
end
