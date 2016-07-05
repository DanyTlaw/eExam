json.array!(@course_of_studies) do |course_of_study|
  json.extract! course_of_study, :id
  json.url course_of_study_url(course_of_study, format: :json)
end
