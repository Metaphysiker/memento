class WorkTimesController < ApplicationController
  before_action :set_work_time, only: [:show, :edit, :update, :destroy]

  # GET /work_times
  # GET /work_times.json
  def index
    @work_times = WorkTime.all
  end

  # GET /work_times/1
  # GET /work_times/1.json
  def show
  end

  # GET /work_times/new
  def new
    @work_time = WorkTime.new
  end

  # GET /work_times/1/edit
  def edit
  end

  # POST /work_times
  # POST /work_times.json
  def create
    @work_time = WorkTime.new(work_time_params)

    respond_to do |format|
      if @work_time.save
        #format.html { redirect_to @work_time, notice: 'Work time was successfully created.' }
        format.html { redirect_to worktime_path, notice: "Arbeitszeit eingetragen!"}
        format.json { render :show, status: :created, location: @work_time }
      else
        format.html { render :new }
        format.json { render json: @work_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_times/1
  # PATCH/PUT /work_times/1.json
  def update
    respond_to do |format|
      if @work_time.update(work_time_params)
        format.html { redirect_to @work_time, notice: 'Work time was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_time }
      else
        format.html { render :edit }
        format.json { render json: @work_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_times/1
  # DELETE /work_times/1.json
  def destroy
    @work_time.destroy
    respond_to do |format|
      format.html { redirect_to work_times_url, notice: 'Work time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_time
      @work_time = WorkTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_time_params
      params.require(:work_time).permit(:date, :task, :user_id, :time, :area, :project, :voluntary)
    end
end
