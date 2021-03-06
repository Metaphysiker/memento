class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Project")
    end
    @records = Search.new(@search_inputs).search
    @records = @records.page(params[:page]).per(20)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @record = @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
        format.js { render :file => "/basic/create.js.erb" }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/faulty_create.js.erb" }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @record = @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
        format.js { render :file => "/basic/update.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/update.js.erb" }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @record = @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def add_people_to_project
    if params[:selection].present? && params[:project_id].present?
      project = Project.find(params[:project_id])
      #project.people << Person.where(id: params[:selection])
      Person.where(id: params[:selection]).each do |person|
        project.people << person unless project.people.include?(person)
      end
    end
  end

  def remove_people_to_project
    if params[:selection].present? && params[:project_id].present?
      project = Project.find(params[:project_id])
      #project.people << Person.where(id: params[:selection])
      Person.where(id: params[:selection]).each do |person|
        project.people.delete(person)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :start, :end)
    end
end
