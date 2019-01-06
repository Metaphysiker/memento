class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  # GET /institutions
  # GET /institutions.json
  def index
    #@institutions = Institution.all
    #@institutions = Institution.order(:name).page(params[:page]).per(20)
=begin
    if params[:search_inputs].present?
      search_inputs = params[:search_inputs]
      klass = class_for(search_inputs[:model])
      search_term = search_inputs[:search_term]
      institutions = search_inputs[:institutions]
      tag_list = search_inputs[:tag_list]
      assigned_to_user_id = search_inputs[:assigned_to_user_id]
      @search_inputs = OpenStruct.new(search_inputs)
    else
      klass = Institution
      search_term = ""
      institutions = ""
      tag_list = ""
      @search_inputs = OpenStruct.new(model: klass)
    end

    @records = Search.new(model: klass, search_term: search_term, tag_list: tag_list, institutions: institutions, assigned_to_user_id: assigned_to_user_id, page: params[:page]).search
=end
=begin
  if params[:search_inputs].present?

    search_inputs = params[:search_inputs]
    klass = class_for(search_inputs[:model])
    search_term = search_inputs[:search_term]
    institutions = search_inputs[:institutions]
    tag_list = search_inputs[:tag_list]
    assigned_to_user_id = search_inputs[:assigned_to_user_id]
    #@search_inputs = OpenStruct.new(search_inputs)
    @search_inputs = params[:search_inputs]

  @records = Search.new(params[:search_inputs].to_h).search
  else
    klass = Institution
    @search_inputs = OpenStruct.new(model: klass)
    #[:search_inputs][:model] = Institution
    #@search_inputs = {model: Institution, search_term: ""}
    @records = Search.new(model: "Institution").search

  end
=end

  if params[:search_inputs].present?
    @search_inputs = OpenStruct.new(params[:search_inputs])
  else
    @search_inputs = OpenStruct.new(model: "Institution")
  end
  @records = Search.new(@search_inputs).search
  @records = @records.page(params[:page]).per(20)

  #@records = Search.new(params[:search_inputs].to_h).search
  #@records = Search.new(model: klass, search_term: search_term, tag_list: tag_list, institutions: institutions, assigned_to_user_id: assigned_to_user_id, page: params[:page]).search

    respond_to do |format|
        format.html
        format.js { render :file => "/basic/search_basic.js.erb" }
    end
  end

  # GET /institutions/1
  # GET /institutions/1.json
  def show
  end

  # GET /institutions/new
  def new
    @institution = Institution.new
  end

  # GET /institutions/1/edit
  def edit
  end

  # POST /institutions
  # POST /institutions.json
  def create
    @institution = Institution.new(institution_params)
    @record = @institution
    respond_to do |format|
      if @institution.save
        format.html { redirect_to @institution, notice: 'Institution was successfully created.' }
        format.json { render :show, status: :created, location: @institution }
        format.js { render :file => "/basic/create.js.erb" }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/faulty_create.js.erb" }
      end
    end
  end

  # PATCH/PUT /institutions/1
  # PATCH/PUT /institutions/1.json
  def update
    @record = @institution
    respond_to do |format|
      if @institution.update(institution_params)
        format.html { redirect_to @institution, notice: 'Institution was successfully updated.' }
        format.json { render :show, status: :ok, location: @institution }
        format.js { render :file => "/basic/update.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/update.js.erb" }
      end
    end
  end

  # DELETE /institutions/1
  # DELETE /institutions/1.json
  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to institutions_url, notice: 'Institution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_institutions
    search_term = params[:search_institutions]

    if search_term.nil? || search_term.empty?
      @institutions = Institution.all
    else
      @institutions = Institution.search_institutions_ilike("%#{search_term}%")
    end

    @institutions = @institutions.order(:name).page(params[:page]).per(20)

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:name, :description, :phone, :email, :website, :functionality_list => [], :target_group_list => [])
    end
end
