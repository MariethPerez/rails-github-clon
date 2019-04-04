class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end




  def update
    user = User.find(params[:id])
    params.keys.each do |key|
      if key != :id && user.attributes.key?(key)
        user[key] = params[key]
      end
    end
    user.save
    render json: user
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end


end