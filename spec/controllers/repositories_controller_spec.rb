require 'rails_helper'

describe RepositoriesController do

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all repositories' do
      user = User.create(
        username: "diegotc86",
        name: "Diego Torres",
        birthday: "07/06/1986",
        email: "diegot86@gmail.com",
        bio: "Diego's bio here",
        company: "Diego's company",
        location: "LIMA - PERU",
        website: "www.diegotorres.dev"
      )
      Repository.create(
        name: 'repo1', 
        description: 'Description of repo1', 
        access: "public", 
        license: "none", 
        user_id: user.id,
        )
      get :index
      repositories = JSON.parse(response.body)
      expect(repositories.size).to eq 1
    end
  end


end