class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.create(
      name: params[:name],
      username: params[:username],
      name: params[:name],
      birthday: params[:birthday],
      email: params[:email],
      bio: params[:bio],
      company: params[:company],
      location: params[:location],
      website: params[:website]
    )
    render json: user, status: :created
  end

  def update
    user = User.find(params[:id])
    params[:attributes].keys.each do |key|
      if key != :id && user.attributes.key?(key)
        user[key] = params[:attributes][key]
      end
    end
    user.save
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render nothing: true, status: :no_content
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end