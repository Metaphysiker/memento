class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    #@people = Person.all.limit(25)
    @people = Person.all
    #@people = Person.all.order(:name).page(params[:page])
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
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.js
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

    #@people = @people.order(:name).page(params[:page])

    respond_to do |format|
      format.js
    end
  end

  def people_navigation
    @offset = params[:offset].to_i
    @limit = params[:limit].to_i
    @people_ids = params[:people_ids].split(' ').map(&:to_i)

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
      params.require(:person).permit(:firstname, :lastname, :email, :phone, :description, :gender)
    end
end
