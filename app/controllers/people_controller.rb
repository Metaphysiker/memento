class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :odf]

  require 'csv'
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
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search
    @records = @records.page(params[:page]).per(20)

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
    @record = @person

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
        format.js { render :file => "/basic/create.js.erb" }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/faulty_create.js.erb" }
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


  def odf
    amount = params[:bill][:amount]
    membership = params[:bill][:membership]

    if membership == "Platinmitglied"
      membership = "Platin-Mitgliedschaft"
      advantages =
      ["Platin-Mitglieder erhalten jährlich eine Kurskostenreduktion von CHF 50.00.",
      "Kostenloser Eintritt zu den Events von Philosophie.ch"]
    else
      membership = "Club 200-Mitgliedschaft"
      advantages =
    "Für 200er-Clubmitglieder sind alle Kurse um 25% (CHF 88.00) reduziert.
    Kostenloser Eintritt zu den Events von Philosophie.ch.
    Die Club200-Mitglieder erhalten neben dem personalisierten, elektronischen Newsletter einmal jährlich handerlesene Tipps rund um Neuerscheinungen, Veranstaltungen und Onlineangebote sowie
    ein jährlich abwechselndes, gedrucktes Produkt (Jahreskalender 2020), und auch
    die gedruckte Broschüre von Philosophie.ch mit zeitnahen, philosophischen Texten per Post.
    Auf Wunsch, Nennung als Gönnermitglied auf Philosophie.ch"
    end

    report = ODFReport::Report.new("#{Rails.root}/app/views/odfs/rechnung.odt") do |r|

      #r.add_image :graphics1, "#{Rails.root}/app/views/odfs/logo1.jpg"
      r.add_field :address, @person.address.address_for_letter
      r.add_field :date, I18n.localize(Date.today, format: '%d.%B %Y').to_s
      r.add_field :amount, amount
      r.add_field :membership, membership
      #r.add_field :advantages, advantages
      #r.add_section :advantages, advantages

    end

    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                            disposition: 'attachment',
                            filename: 'rechnung.odt'

  end

  def serienbrief

    #@institutions = Institution.last(5)
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    report = ODFReport::Report.new("#{Rails.root}/app/views/odfs/versand-an-lehrpersonen-iteration-it.odt") do |r|
    #report = ODFReport::Report.new("#{Rails.root}/app/views/odfs/serienbrief.odt") do |r|
       #r.add_field :address, @institution.address.address_for_letter
       #r.add_field :date, I18n.localize(Date.today, format: '%d.%B %Y').to_s

       r.add_section("page", @records) do |s|
         s.add_field(:address) {|record| record.address.address_for_letter}
         s.add_field(:date) {I18n.localize(Date.today, format: '%d. %B %Y').to_s}
       end

    end

    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                            disposition: 'attachment',
                            filename: 'serienbrief.odt'

  end

  def brief_an_mitglieder

    #@institutions = Institution.last(5)
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    report = ODFReport::Report.new("#{Rails.root}/app/views/odfs/serienbrief-brief-an-mitglieder.odt") do |r|
       #r.add_field :address, @institution.address.address_for_letter
       #r.add_field :date, I18n.localize(Date.today, format: '%d.%B %Y').to_s

       r.add_section("page", @records) do |s|
         s.add_field(:address) {|record| record.address.address_for_letter}
         s.add_field(:date) {I18n.localize(Date.today, format: '%d. %B %Y').to_s}
       end
     end

     send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                             disposition: 'attachment',
                             filename: 'brief-an-mitglieder.odt'

   end

  def odf_of_list_of_members

    year = params[:list][:year]
    #year = 2019

    platin_members = Person.tagged_with("Platinmitglied", :on => :functionalities)
    twohundred_members = Person.tagged_with("200er-Mitglied", :on => :functionalities)
    alumni_members = Person.tagged_with("Alumnimitglied", :on => :functionalities)

    report = ODFReport::Report.new("#{Rails.root}/app/views/odfs/odf_of_list_of_members.odt") do |r|
      r.add_field :date, I18n.localize(Date.today, format: '%d.%B %Y').to_s
      r.add_field :year, year.to_s

      r.add_table("TABLE_1", platin_members, :header=>true) do |t|
        t.add_column(:member_name) { |item| "#{item.name}" }
        t.add_column(:member_email) { |item| "#{item.email}" }
        t.add_column(:member_paid) { |item| "#{item.payments.where(date: Date.parse("#{year}-01-01").beginning_of_year..Date.parse("#{year}-01-01").end_of_year).any? ? "Ja" : "Nein"}" }
      end

      r.add_table("TABLE_2", twohundred_members, :header=>true) do |t|
        t.add_column(:member_name) { |item| "#{item.name}" }
        t.add_column(:member_email) { |item| "#{item.email}" }
        t.add_column(:member_paid) { |item| "#{item.payments.where(date: Date.parse("#{year}-01-01").beginning_of_year..Date.parse("#{year}-01-01").end_of_year).any? ? "Ja" : "Nein"}" }
      end

      r.add_table("TABLE_3", alumni_members, :header=>true) do |t|
        t.add_column(:member_name) { |item| "#{item.name}" }
        t.add_column(:member_email) { |item| "#{item.email}" }
        t.add_column(:member_paid) { |item| "#{item.payments.where(date: Date.parse("#{year}-01-01").beginning_of_year..Date.parse("#{year}-01-01").end_of_year).any? ? "Ja" : "Nein"}" }
      end

    end

    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                            disposition: 'attachment',
                            filename: "mitgliederverzeichnis-#{year}.odt"

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:form_of_address, :firstname, :lastname, :email, :phone, :phone2, :description, :gender, :language, :website, :institution_ids => [], :functionality_list => [], :target_group_list => [], :topic_ids => [])
    end
end
