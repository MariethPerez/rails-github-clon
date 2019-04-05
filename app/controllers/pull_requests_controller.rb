class PullRequestsController < ApplicationController

  def index
    render json: PullRequest.all
  end

  def show
    render json: PullRequest.find(params[:id])
  end

  def create
    pull_request = PullRequest.create(title: params[:title],description: params[:description],label: params[:label],user_id: params[:user_id])
    render json: pull_request, status: :created
  end

  def update
    pull_request = PullRequest.find(params[:id])
    params.keys.each do |key|
      if key != :id && pull_request.attributes.key?(key)
        pull_request[key] = params[key]
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