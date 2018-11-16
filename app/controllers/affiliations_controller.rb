class AffiliationsController < ApplicationController
  before_action :set_affiliation, only: [:show, :edit, :update, :destroy]

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @affiliation.update(affiliation_params)
        format.html { redirect_to root_path, notice: 'Funktion wurde aktualisiert.' }
        format.json { render :show, status: :ok, location: @affiliation }
      else
        format.html { render :edit }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
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
