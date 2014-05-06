class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  # GET /instructors
  # GET /instructors.json
  def index
    #paginate the index view
    @instructors = Instructor.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactiveInstructors = Instructor.inactive.alphabetical.paginate(page: params[:page]).per_page(10)

  end

  # GET /instructors/e
  # GET /instructors/1.json
  def show
    @instructor = Instructor.find(params[:id])
    @camps = @instructor.camps.chronological.paginate(page: params[:page]).per_page(4)
    @upcomingCamps = @instructor.camps.upcoming.chronological.paginate(page: params[:page]).per_page(4)
    @pastCamps = @instructor.camps.past.chronological.paginate(page: params[:page]).per_page(4)
    @instructor.active ? @status = "Active" : @status = "Inactive"
    if @instructor.user.present? then
      @role = @instructor.user.role
      @username = @instructor.user.username
    end
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
    #should do something here with the build and what if there is no user
    @instructor.build_user
  end

  # GET /instructors/1/edit
  def edit
    @instructor = Instructor.find(params[:id])
    # authorize! :edit, @instructor
    if @instructor.user.nil?
      @instructor.build_user
    end
  end

  # POST /instructors
  # POST /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    respond_to do |format|
      if @instructor.save
        format.html { redirect_to @instructor, notice: "#{@instructor.first_name} #{@instructor.last_name} was added to the system." }
        format.json { render action: 'show', status: :created, location: @instructor }
      else
        format.html { render action: 'new' }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update
    respond_to do |format|
      if @instructor.update(instructor_params)
        format.html { redirect_to @instructor, notice: "#{@instructor.first_name} #{@instructor.last_name} was revised in the system." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1
  # DELETE /instructors/1.json
  def destroy
    @instructor.destroy
    respond_to do |format|
      format.html { redirect_to instructors_url, notice: "#{@instructor.first_name} #{@instructor.last_name} was removed from the system." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:first_name, :last_name, :bio, :photo, :email, :phone, :active, user_attributes: [:id, :username, :password, :password_confirmation, :instructor_id, :role])
    end
end
