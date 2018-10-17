class TagListsController < ApplicationController
  before_action :set_tag_list, only: [:show, :edit, :update, :destroy]

  # GET /tag_lists
  # GET /tag_lists.json
  def index
    @tag_lists = TagList.all
  end

  # GET /tag_lists/1
  # GET /tag_lists/1.json
  def show
  end

  # GET /tag_lists/new
  def new
    @tag_list = TagList.new
  end

  # GET /tag_lists/1/edit
  def edit
  end

  # POST /tag_lists
  # POST /tag_lists.json
  def create
    @tag_list = TagList.new(tag_list_params)

    respond_to do |format|
      if @tag_list.save
        format.html { redirect_to @tag_list, notice: 'Tag list was successfully created.' }
        format.json { render :show, status: :created, location: @tag_list }
      else
        format.html { render :new }
        format.json { render json: @tag_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_lists/1
  # PATCH/PUT /tag_lists/1.json
  def update
    respond_to do |format|
      if @tag_list.update(tag_list_params)
        format.html { redirect_to @tag_list, notice: 'Tag list was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_list }
      else
        format.html { render :edit }
        format.json { render json: @tag_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_lists/1
  # DELETE /tag_lists/1.json
  def destroy
    @tag_list.destroy
    respond_to do |format|
      format.html { redirect_to tag_lists_url, notice: 'Tag list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_list
      @tag_list = TagList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_list_params
      params.require(:tag_list).permit(:name)
    end
end
