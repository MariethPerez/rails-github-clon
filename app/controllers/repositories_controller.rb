class RepositoriesController < ApplicationController

  def index
    render json: Repository.all
  end

end