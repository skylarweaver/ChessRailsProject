class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]


  # GET /camps
  # GET /camps.json
  def index
    @camps = Camp.active.chronological.paginate(page: params[:page]).per_page(10)
    @inactiveCamps =  Camp.inactive.chronological.paginate(page: params[:page]).per_page(10)
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
    @camp = Camp.find(params[:id])
    @camp.time_slot == "am" ? @timeSlot = "Morning" : @timeSlot = "Afternoon"
    @instructors = @camp.instructors.alphabetical.paginate(page: params[:page]).per_page(4)
    @location = @camp.location
    
    @dates = "#{@camp.start_date.strftime("%m/%d/%y")} - #{@camp.end_date.strftime("%m/%d/%y")}"
    @camp.active ? @status = "Active" : @status = "Inactive"

  end

  # GET /camps/new
  def new
    @camp = Camp.new
    @alphCurrics = Curriculum.active.alphabetical
  end

  # GET /camps/1/edit
  def edit
    @alphCurrics = Curriculum.active.alphabetical
    @camp = Camp.find(params[:id])
    @allInstructors = Instructor.active.alphabetical

  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: "#{@camp.name} was added to the system." }
        format.json { render action: 'show', status: :created, location: @camp }
      else
        format.html { render action: 'new' }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camps/1
  # PATCH/PUT /camps/1.json
  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to @camp, notice: "#{@camp.name} was revised in the system." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to camps_url, notice: "#{@camp.name} was removed from the system." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_params
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active, instructor_ids: [])
    end
end
