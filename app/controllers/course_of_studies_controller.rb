class CourseOfStudiesController < ApplicationController
  before_action :set_course_of_study, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user! 

  # GET /course_of_studies
  # GET /course_of_studies.json
  def index
    @course_of_studies = CourseOfStudy.all
  end

  # GET /course_of_studies/1
  # GET /course_of_studies/1.json
  def show
  end

  # GET /course_of_studies/new
  def new
    @course_of_study = CourseOfStudy.new
  end

  # GET /course_of_studies/1/edit
  def edit
  end

  # POST /course_of_studies
  # POST /course_of_studies.json
  def create
    @course_of_study = CourseOfStudy.new(course_of_study_params)

    respond_to do |format|
      if @course_of_study.save
        format.html { redirect_to @course_of_study, notice: 'Course of study was successfully created.' }
        format.json { render :show, status: :created, location: @course_of_study }
      else
        format.html { render :new }
        format.json { render json: @course_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_of_studies/1
  # PATCH/PUT /course_of_studies/1.json
  def update
    respond_to do |format|
      if @course_of_study.update(course_of_study_params)
        format.html { redirect_to @course_of_study, notice: 'Course of study was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_of_study }
      else
        format.html { render :edit }
        format.json { render json: @course_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_of_studies/1
  # DELETE /course_of_studies/1.json
  def destroy
    @course_of_study.destroy
    respond_to do |format|
      format.html { redirect_to course_of_studies_url, notice: 'Course of study was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_of_study
      @course_of_study = CourseOfStudy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_of_study_params
      params.require(:course_of_study).permit(:name, :semester)
    end
end
