class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @courses = @course_of_study.courses
  end

  def all
    @courses = Course.all
  end
  # GET /courses/1
  # GET /courses/1.json
  def show
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = @course_of_study.courses.find(params[:id])
  end

  # GET /courses/new
  def new
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = @course_of_study.courses.build
  end

  # GET /courses/1/edit
  def edit
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    puts @course_of_study.id
    @course = @course_of_study.courses.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = @course_of_study.courses.build(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_of_study_courses_path(@course_of_study, @course), notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = @course_of_study.courses.find(params[:id])

    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_of_study_courses_path(@course_of_study, @course), notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to course_of_study_courses_path, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end
end
