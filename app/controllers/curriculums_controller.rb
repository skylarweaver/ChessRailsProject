class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  # GET /curriculums
  # GET /curriculums.json
  def index
    @curriculums = Curriculum.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactiveCurriculums = Curriculum.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show
    @curriculum = Curriculum.find(params[:id])
    @camps = @curriculum.camps.chronological.paginate(page: params[:page]).per_page(10)

    @curriculum.active ? @status = "Active" : @status = "Inactive"
  end

  # GET /curriculums/new
  def new 
    @curriculum = Curriculum.new
  end

  # GET /curriculums/1/edit
  def edit
  end

  # POST /curriculums
  # POST /curriculums.json
  def create
    @curriculum = Curriculum.new(curriculum_params)

    respond_to do |format|
      if @curriculum.save
        format.html { redirect_to @curriculum, notice: "#{@curriculum.name} was added to the system." }
        format.json { render action: 'show', status: :created, location: @curriculum }

      else
        format.html { render action: 'new' }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /curriculums/1
  # PATCH/PUT /curriculums/1.json
  def update
    respond_to do |format|
      if @curriculum.update(curriculum_params)
        format.html { redirect_to @curriculum, notice: "#{@curriculum.name} was revised in the system." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculums/1
  # DELETE /curriculums/1.json
  def destroy
    @curriculum.destroy
    respond_to do |format|
      format.html { redirect_to curriculums_url, notice: "#{@curriculum.name} was removed from the system." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curriculum_params
      params.require(:curriculum).permit(:name, :description, :min_rating, :max_rating, :active)
    end
    
    def adjust_ratings
      params[:curriculum][:min_rating] = 0 if params[:curriculum][:min_rating].nil?
      params[:curriculum][:max_rating] = 3000 if params[:curriculum][:max_rating].nil? 
    end
end
