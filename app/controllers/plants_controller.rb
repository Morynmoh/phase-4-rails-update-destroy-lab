class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # Delete /plants
  def destroy
    plant = find_plant
    plant.destroy
    render json: { message: 'plant deleted' }, status: :no_content
  end

  # PATCH /plants
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, except: %i[updated_at created_at], status: :accepted
  end

  private

  def render_not_found_response
    render json: { error: 'Not Found' }, status: :not_found
  end

  def find_plant
    plant = Plant.find(params[:id])
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
