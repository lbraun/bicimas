class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy, :toggle_favorite]

  # GET /stations
  # GET /stations.json
  def index
    @favorite_station_ids = favorite_station_ids
    @stations = Station.all.sort_by { |station| station.popularity_rank }
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
  end

  # GET /stations/new
  def new
    @station = Station.new
  end

  # GET /stations/1/edit
  def edit
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'Station was successfully created.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /stations/refresh
  # GET /stations/refresh.json
  def refresh
    Station.pull_data

    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'Stations were successfully refreshed.' }
      format.json { head :no_content }
    end
  end

  # GET /stations/1/toggle_favorite
  def toggle_favorite
    ids = favorite_station_ids

    notice =
      if ids.include?(@station.id)
        cookies[:favorite_station_ids] = ids -= [@station.id]
        "#{@station} is no longer one of your favorites."
      else
        cookies[:favorite_station_ids] = ids += [@station.id]
        "#{@station} is now one of your favorites!"
      end

    respond_to do |format|
      format.html { redirect_to stations_url, notice: notice }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:number, :coordinate_x, :coordinate_y, :name)
    end
end
