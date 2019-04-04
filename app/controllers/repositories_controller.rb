class RepositoriesController < ApplicationController

  def index
    render json: Repository.all
  end

  def show
    render json: Repository.find(params[:id])
    end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end