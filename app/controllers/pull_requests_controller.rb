class PullRequestsController < ApplicationController

  def index
    if params["branch_id"]
      render json: PullRequest.where(branch_in_id: params["branch_id"]).or(PullRequest.where(branch_out_id: params["branch_id"]))
    else
      render json: PullRequest.all
    end
  end

  def show
    render json: PullRequest.find(params[:id])
  end

  def create
    pull_request = PullRequest.create(
      title: params[:title],
      description: params[:description],
      status: params[:status],
      branch_in_id: params[:branch_in],
      branch_out_id: params[:branch_out]
      )
    render json: pull_request, status: :created
  end

  def update
    pull_request = PullRequest.find(params[:id])
    params[:attributes].keys.each do |key|
      if key != :id && pull_request.attributes.key?(key)
        pull_request[key] = params[:attributes][key]
      end
    end
    pull_request.save
    render json: pull_request
  end

  def destroy
    pull_request = PullRequest.find(params[:id])
    pull_request.destroy
    render nothing: true, status: :no_content
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
  
end