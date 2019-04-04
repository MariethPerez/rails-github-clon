class RepositoriesController < ApplicationController

  def index
    render json: Repository.all
  end

  def show
    render json: Repository.find(params[:id])
    end

  def create
    repository = Repository.create(
      name: params[:name], 
      description: params[:description], 
      access: params[:access], 
      license: params[:license], 
      user_id: params[:user_id],
      )
    render json: repository, status: :created
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end