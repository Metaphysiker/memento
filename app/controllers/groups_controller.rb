class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Group")
    end
    @records = Search.new(@search_inputs).search
    @records = @records.page(params[:page]).per(20)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create

    @group = Group.new(group_params)
    #byebug
    @record = @group
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
        format.js { render :file => "/basic/create.js.erb" }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/faulty_create.js.erb" }
      end
    end
  end

  def create_for_project

    @group = Group.new(group_params)
    @parent = @group.projects.first
    @record = @group
    #byebug
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
        format.js
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @record = @group
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
        format.js { render :file => "/basic/update.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/update.js.erb" }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @record = @group
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def add_people_to_group
    if params[:selection].present? && params[:group_id].present?
      group = Group.find(params[:group_id])
      #group.people << Person.where(id: params[:selection])
      Person.where(id: params[:selection]).each do |person|
        group.people << person unless group.people.include?(person)
      end
    end
  end

  def remove_people_from_group
    if params[:selection].present? && params[:group_id].present?
      group = Group.find(params[:group_id])
      #group.people << Person.where(id: params[:selection])
      Person.where(id: params[:selection]).each do |person|
        group.people.delete(person)
      end
    end
  end

  def search_selectable_list_to_add_people
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @group = Group.find(params[:search_inputs][:group])
    @records = Search.new(@search_inputs).search.where.not(id: @group.people.pluck(:id))

    respond_to do |format|
      format.js
    end
  end

  def search_selectable_list_to_remove_people
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search
    @group = Group.find(params[:search_inputs][:group])

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :project_ids => [])
    end
end
