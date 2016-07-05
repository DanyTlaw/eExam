require 'test_helper'

class CourseOfStudiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_of_study = course_of_studies(:one)
  end

  test "should get index" do
    get course_of_studies_url
    assert_response :success
  end

  test "should get new" do
    get new_course_of_study_url
    assert_response :success
  end

  test "should create course_of_study" do
    assert_difference('CourseOfStudy.count') do
      post course_of_studies_url, params: { course_of_study: {  } }
    end

    assert_redirected_to course_of_study_url(CourseOfStudy.last)
  end

  test "should show course_of_study" do
    get course_of_study_url(@course_of_study)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_of_study_url(@course_of_study)
    assert_response :success
  end

  test "should update course_of_study" do
    patch course_of_study_url(@course_of_study), params: { course_of_study: {  } }
    assert_redirected_to course_of_study_url(@course_of_study)
  end

  test "should destroy course_of_study" do
    assert_difference('CourseOfStudy.count', -1) do
      delete course_of_study_url(@course_of_study)
    end

    assert_redirected_to course_of_studies_url
  end
end
