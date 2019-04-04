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

  describe 'GET show' do
    it 'returns http status ok' do
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
      repository = Repository.create(
      name: 'repo1', 
      description: 'Description of repo1', 
      access: "public", 
      license: "none", 
      user_id: user.id,
      )
      get :show, params: { id: repository }
      expect(response).to have_http_status(:ok)
    end
    
    it 'render the correct repository' do
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
      repository = Repository.create(
      name: 'repo1', 
      description: 'Description of repo1', 
      access: "public", 
      license: "none", 
      user_id: user.id,
      )
      get :show, params: { id: repository }
      expected_repository = JSON.parse(response.body)
      expect(expected_repository["id"]).to eq(repository.id)
    end
    
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST create" do
    it "returns http status created" do
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
      
      post :create, params: {
        name: 'repo1', 
        description: 'Description of repo1', 
        access: "public", 
        license: "none", 
        user_id: user.id,
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created repository" do
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
      
      post :create, params: {
        name: 'repo1', 
        description: 'Description of repo1', 
        access: "public", 
        license: "none", 
        user_id: user.id,
      }
      expected_repository = JSON.parse(response.body)
      expect(expected_repository).to have_key("id")
      expect(expected_repository["name"]).to eq("repo1")
    end
  end

  describe "PATCH update" do
    it "returns http status ok" do
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
      repository = Repository.create(
      name: 'repo1', 
      description: 'Description of repo1', 
      access: "public", 
      license: "none", 
      user_id: user.id,
      )
      patch :update, params: { id: repository, attributes: {name: "repo1 updated", access: "private"}}
      expect(response).to have_http_status(:ok)
    end

    it "returns the updated product" do
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
      repository = Repository.create(
        name: 'repo1', 
        description: 'Description of repo1', 
        access: "public", 
        license: "none", 
        user_id: user.id,
      )
      patch :update, params: { id: repository, attributes: {name: "repo1 updated", access: "private"}}
      expected_repository = JSON.parse(response.body)
      expect(expected_repository["name"]).to eq("repo1 updated")
      expect(expected_repository["access"]).to eq("private")
    end
  end

end