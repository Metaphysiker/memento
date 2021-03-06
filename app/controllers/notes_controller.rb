class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    #@notes = Note.all
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Note")
    end
    @records = Search.new(@search_inputs).search
    @records = @records.page(params[:page]).per(20)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @record = @note

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
        format.js { render :file => "/basic/reload_children.js.erb" }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/reload_children.js.erb" }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @record = @note
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
        format.js { render :file => "/basic/update.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        format.js { render :file => "/basic/update.js.erb" }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @record = @note
    @note.destroy
    puts @record.inspect

    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
      #format.js { render :file => "/basic/reload_children.js.erb" }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:description, :noteable_id, :noteable_type)
    end
end
