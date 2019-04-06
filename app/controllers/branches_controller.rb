class BranchesController < ApplicationController

  def index
    if params["repository_id"]
      render json: Branch.where(repository_id: params["repository_id"])
    else
      render json: Branch.all
    end
  end
  
  def show
    render json: Branch.find(params[:id])
  end

  def create
    branch = Branch.create(name: params[:name], user_id: params[:user_id] , repository_id: params[:repository_id])
    render json: branch, status: :created
  end

  def update
    branch = Branch.find(params[:id])
    params.keys.each do |key|
      if key != :id && branch.attributes.key?(key)
        branch[key] = params[key]
      end
    end
    branch.save
    render json: branch
  end

  def destroy
    branch = Branch.find(params[:id])
    branch.destroy
    render nothing: true, status: :no_content
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end