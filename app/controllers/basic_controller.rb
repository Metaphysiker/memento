class BasicController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  require 'csv'
  require 'zip'

  # GET /people
  # GET /people.json
  def index
    #@people = Person.order(:name).page(params[:page]).per(20)
    #@institutions = Institution.order(:name).page(params[:page]).per(20)
    #@people = Person.all.limit(25)
    #@people = Person.all
    #@people = Person.all.order(:name).page(params[:page])
    respond_to do |format|
        format.html
        format.js { render :file => "/basic/search_basic.js.erb" }
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

  def search_basic
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search
    @records = @records.page(params[:page]).per(20)
    #byebug
    respond_to do |format|
      format.js
    end
  end

  def csv
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    send_data @records.to_csv, filename: "#{@search_inputs.model.to_s}-#{Date.today}.csv"
  end

  def pdf
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

  respond_to do |format|
      format.pdf do
        render pdf: "#{@search_inputs.model.to_s}-#{Date.today}.pdf",
        template: "basic/pdf.html.erb",
        layout: "pdf_layout.html",
        dpi: 75
      end
    end
  end

  def odf
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    compressed_filestream = Zip::OutputStream.write_buffer do |zos|

      @records.each do |person|
        report = ODFReport::Report.new("#{Rails.root}/app/views/odfs/rechnung.odt") do |r|
          r.add_image :graphics1, "#{Rails.root}/app/views/odfs/logo1.jpg"
          r.add_field :name, "#{person.firstname} #{person.lastname}"
          r.add_field :street, person.address.street.to_s
          r.add_field :location, "#{person.address.plz} #{person.address.location}"
          r.add_field :date, I18n.localize(Date.today, format: '%d.%B %Y').to_s
        end
        zos.put_next_entry "#{person.name}-#{person.id}".parameterize + ".odt"
        zos.write report.generate
      end
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: "odfs.zip"

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
