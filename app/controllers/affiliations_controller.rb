class AffiliationsController < ApplicationController
  before_action :set_affiliation, only: [:show, :edit, :update, :destroy, :update_institution_affiliation, :update_person_affiliation]

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @record = @affiliation
    respond_to do |format|
      if @affiliation.update(affiliation_params)
        format.html { redirect_to root_path, notice: 'Funktion wurde aktualisiert.' }
        format.json { render :show, status: :ok, location: @affiliation }
        format.js { render :file => "/affiliations/update_person_affiliation.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update_person_affiliation
    @record = @affiliation
    respond_to do |format|
      if @affiliation.update(affiliation_params)
        format.html { redirect_to root_path, notice: 'Funktion wurde aktualisiert.' }
        format.json { render :show, status: :ok, location: @affiliation }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update_institution_affiliation
    @record = @affiliation
    respond_to do |format|
      if @affiliation.update(affiliation_params)
        format.html { redirect_to root_path, notice: 'Funktion wurde aktualisiert.' }
        format.json { render :show, status: :ok, location: @affiliation }
        format.js { render :file => "/affiliations/update_person_affiliation.js.erb" }
      else
        format.html { render :edit }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliation
      @affiliation = Affiliation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def affiliation_params
      params.require(:affiliation).permit(:function)
    end

end
