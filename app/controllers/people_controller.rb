class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
=begin
    search_inputs = params[:search_inputs]
    klass = class_for(search_inputs[:model]) || Person
    search_term = search_inputs[:search_term] || ""
    institutions = search_inputs[:institutions] || ""
    tag_list = search_inputs[:tag_list] || ""

    @records = Search.new(model: klass, search_term: search_term, tag_list: tag_list, institutions: institutions, page: params[:page]).search
    @search_inputs = params[:search_inputs]
=end

    #@people = Person.all.order(:name).page(params[:page]).per(20)
    #@people = Person.all.limit(25)
    #@people = Person.all
    #@people = Person.all.order(:name).page(params[:page])
    if params[:search_inputs].present?
      search_inputs = params[:search_inputs]
      search_inputs[:page] = params[:page]
      @records = Search.new(search_inputs).search
      @search_inputs = OpenStruct.new(search_inputs)
    else
      @records = Search.new(model: "Person").search
    end
    
    respond_to do |format|
        format.html
        format.js { render :file => "/people/search_people.js.erb" }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @record = @person
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
        format.js { render :file => "/basic/update.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/update.js.erb" }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_people
    search_term = params[:search_people]

    if search_term.nil? || search_term.empty?
      @people = Person.all
    else
      @people = Person.search_people_ilike("%#{search_term}%")
    end

    @people = @people.order(:name).page(params[:page]).per(20)

    respond_to do |format|
      format.js
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:firstname, :lastname, :email, :phone, :description, :gender, :institution_ids => [], :tag_list => [])
    end
end
