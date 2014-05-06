class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  # GET /families
  # GET /families.json
  def index
    @inactiveFamilies = Family.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
    @families = Family.active.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  # GET /families/1
  # GET /families/1.json
  def show
    @family= Family.find(params[:id])
    @family.active ? @status = "Yes" : @status = "No"
    @students = @family.students.paginate(page: params[:page]).per_page(10)
    @upcomingCamps=Hash.new
    @students.each do |student|
      @camps = student.camps.active.upcoming
      @camps.each do |camp|
        @upcomingCamps["#{student.first_name}"] = camp
      end
    end
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)

    respond_to do |format|
      if @family.save
        format.html { redirect_to @family, notice: "#{@family.family_name} family was added to the system." }
        format.json { render action: 'show', status: :created, location: @family }
      else
        format.html { render action: 'new' }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to @family, notice: "#{@family.family_name} family was revised in the system." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :email, :phone, :active)
    end
end
