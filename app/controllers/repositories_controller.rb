class RepositoriesController < ApplicationController


  def index
    case
    when params[:user_id]
      render json: Repository.where(user_id: params["user_id"])
    else
      render json: Repository.all
    end
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

  def update
    repository = Repository.find(params[:id])
    params[:attributes].keys.each do |key|
      repository[key] = params[:attributes][key]
    end
    repository.save
    render json: repository
  end

  def destroy
    repository = Repository.find(params[:id])
    repository.destroy
    render nothing: true, status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end