
class StudentsController < ApplicationController
  include ActionController::Live
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user! 

  # GET /students
  # GET /students.json
  def index
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @students = @course.students
  end

  def dashboard
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @students = @course.students

  end

  def getCourseStudents
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @students = @course.students
    render json: @students
  end

  def watch

  end

  def index_stream
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @students = @course.students
    puts "LAAAAAAAAAAAAAAAAAAAAUFT"
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream)

      begin
        sse.write(@students.as_json, event: 'results')
      rescue IOError
      ensure
        sse.close
      end

  end

  # GET /students/1
  # GET /students/1.json
  def show
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])

    @student = @course.students.find(params[:id])
  end

  # GET /students/new
  def new
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @student =  @course.students.build
  end

  # GET /students/1/edit
  def edit
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @student = @course.students.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @student = @course.students.build(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to course_of_study_course_student_path(@course_of_study, @course, @student), notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    @course_of_study = CourseOfStudy.find(params[:course_of_study_id])
    @course = Course.find(params[:course_id])
    @student = @course.students.find(params[:id])
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to course_of_study_course_student_path(@course_of_study,@course, @student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to course_of_study_course_student_path, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:email, :check)
    end

    def recently_changed? last_user
      last_user.updated_at > 5.second.ago
    end
end
