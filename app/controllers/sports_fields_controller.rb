class SportsFieldsController < ApplicationController
  before_action :set_sports_field, only: %i[ show update destroy ]
  skip_before_action :authenticate_user!, only: [:index]

  # GET /sports_fields
  def index
    @sports_fields = SportsField.where(is_active: true)
    render json: @sports_fields
  end

  # GET /sports_fields/1
  def show
    render json: @sports_field
  end

  # POST /sports_fields
  def create
    @sports_field = SportsField.new(sports_field_params)

    if @sports_field.save
      render json: @sports_field, status: :created, location: @sports_field
    else
      render json: @sports_field.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sports_fields/1
  def update
    if @sports_field.update(sports_field_params)
      render json: @sports_field
    else
      render json: @sports_field.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sports_fields/1
  def destroy
    @sports_field.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sports_field
      @sports_field = SportsField.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def sports_field_params
      params.expect(sports_field: [ :name, :owner_id, :field_type, :address, :latitude, :longitude, :hourly_rate,
                                    :description, :image_url, :is_active ])
    end
end
