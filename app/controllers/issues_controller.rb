class IssuesController < ApplicationController
  
  def index
    case
    when params[:user_id]
      render json: Issue.where(user_create_id: params["user_id"]).or(Issue.where(user_assign_id: params["user_id"]))
    when params[:repository_id]
      render json: Issue.where(repository_id: params["repository_id"])
    else
      render json: Issue.all
    end
  end

  def show
    render json: Issue.find(params[:id])
  end

  def create
    issue = Issue.create(
      title: params[:title], 
      description: params[:description], 
      label: params[:label], 
      user_create_id: params[:user_create_id], 
      user_assign_id: params[:user_assign_id],
      repository_id: params[:repository_id]
    )
    render json: issue, status: :created
  end

  def update
    issue = Issue.find(params[:id])
    params[:attributes].keys.each do |key|
        issue[key] = params[:attributes][key]
    end
    issue.save
    render json: issue
  end

  def destroy
    issue = Issue.find(params[:id])
    issue.destroy
    render nothing: true, status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
  
end