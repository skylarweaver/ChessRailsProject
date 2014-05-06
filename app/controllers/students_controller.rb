class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource
  # load_resource

  # GET /students
  # GET /students.json
  def index
    @allStudents = Student.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactiveStudents = Student.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
    # @allStudents = Student.active.alphabetical.accessible_by(current_ability).all
    # @specificStudents = @allStudents.map { |student| student if (can? :read, student)}
    # @allStudents = @allStudents.accessible_by(current_ability)
    # @specificStudents = @specificStudents.paginate(:page => params[:page], :per_page => 30)
    @allStudents.paginate(page: params[:page]).per_page(4)
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student.active ? @status = "Yes" : @status = "No"
    @student = Student.find(params[:id])
    @registrations = @student.registrations.paginate(page: params[:page]).per_page(10)
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "#{@student.first_name} #{@student.last_name} was added to the system." }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "#{@student.first_name} #{@student.last_name} was revised in the system." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
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
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end
