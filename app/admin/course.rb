ActiveAdmin.register Course do

  permit_params  :name, :course_of_study_id,
    course_of_study_attributes: [:id, :name]



end
