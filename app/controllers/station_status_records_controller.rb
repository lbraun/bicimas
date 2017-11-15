class StationStatusRecordsController < ApplicationController
  before_action :set_station_status_record, only: [:show, :edit, :update, :destroy]

  # GET /station_status_records
  # GET /station_status_records.json
  def index
    @station_status_records = StationStatusRecord.all
  end

  # GET /station_status_records/1
  # GET /station_status_records/1.json
  def show
  end

  # GET /station_status_records/new
  def new
    @station_status_record = StationStatusRecord.new
  end

  # GET /station_status_records/1/edit
  def edit
  end

  # POST /station_status_records
  # POST /station_status_records.json
  def create
    @station_status_record = StationStatusRecord.new(station_status_record_params)

    respond_to do |format|
      if @station_status_record.save
        format.html { redirect_to @station_status_record, notice: 'Station status record was successfully created.' }
        format.json { render :show, status: :created, location: @station_status_record }
      else
        format.html { render :new }
        format.json { render json: @station_status_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /station_status_records/1
  # PATCH/PUT /station_status_records/1.json
  def update
    respond_to do |format|
      if @station_status_record.update(station_status_record_params)
        format.html { redirect_to @station_status_record, notice: 'Station status record was successfully updated.' }
        format.json { render :show, status: :ok, location: @station_status_record }
      else
        format.html { render :edit }
        format.json { render json: @station_status_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /station_status_records/1
  # DELETE /station_status_records/1.json
  def destroy
    @station_status_record.destroy
    respond_to do |format|
      format.html { redirect_to station_status_records_url, notice: 'Station status record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_status_record
      @station_status_record = StationStatusRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_status_record_params
      params.require(:station_status_record).permit(:station_id, :bikes_total, :bikes_available, :anchors, :last_seen, :online, :ip, :number_loans)
    end
end
