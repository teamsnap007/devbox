class AdUnitsController < ApplicationController
  before_action :set_ad_unit, only: %i[ show edit update destroy ]

  # GET /ad_units or /ad_units.json
  def index
    @ad_units = AdUnit.all
  end

  # GET /ad_units/1 or /ad_units/1.json
  def show
  end

  # GET /ad_units/new
  def new
    @ad_unit = AdUnit.new
  end

  # GET /ad_units/1/edit
  def edit
  end

  # POST /ad_units or /ad_units.json
  def create
    @ad_unit = AdUnit.new(ad_unit_params)

    respond_to do |format|
      if @ad_unit.save
        format.html { redirect_to ad_unit_url(@ad_unit), notice: "Ad unit was successfully created." }
        format.json { render :show, status: :created, location: @ad_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ad_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_units/1 or /ad_units/1.json
  def update
    respond_to do |format|
      if @ad_unit.update(ad_unit_params)
        format.html { redirect_to ad_unit_url(@ad_unit), notice: "Ad unit was successfully updated." }
        format.json { render :show, status: :ok, location: @ad_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ad_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_units/1 or /ad_units/1.json
  def destroy
    @ad_unit.destroy

    respond_to do |format|
      format.html { redirect_to ad_units_url, notice: "Ad unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_unit
      @ad_unit = AdUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ad_unit_params
      params.require(:ad_unit).permit(:cpi, :url, :image_url, :media_url, :campaign_id, :name, :is_active, :total_impressions, :total_conversions)
    end
end
