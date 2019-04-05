require 'rails_helper'

describe PullRequestsController do 
  
  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all pull requests' do
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
      branch_master = Branch.create(
        name: 'master',
        repository_id: repository.id,
        user_id: user.id
      )
      branch_1 = Branch.create(
        name: '1',
        user_id: user.id,
        repository_id: repository.id
      )
      PullRequest.create(
        title: 'Resolve #1',
        status: true,
        description: 'Resolve #1',
        branch_in: branch_master,
        branch_out: branch_1
      )
      get :index
      pull_request = JSON.parse(response.body)
      expect(pull_request.size).to eq 1
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
      branch_master = Branch.create(
        name: 'master',
        repository_id: repository.id,
        user_id: user.id
      )
      branch_1 = Branch.create(
        name: '1',
        user_id: user.id,
        repository_id: repository.id
      )
      pull_request = PullRequest.create(
        title: 'Resolve #1',
        status: true,
        description: 'Resolve #1',
        branch_in: branch_master,
        branch_out: branch_1
      )
      get :show, params: { id: pull_request }
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
      branch_master = Branch.create(
        name: 'master',
        repository_id: repository.id,
        user_id: user.id
      )
      branch_1 = Branch.create(
        name: '1',
        user_id: user.id,
        repository_id: repository.id
      )
      pull_request = PullRequest.create(
        title: 'Resolve #1',
        status: true,
        description: 'Resolve #1',
        branch_in: branch_master,
        branch_out: branch_1
      )
      get :show, params: { id: pull_request }
      expected_repository = JSON.parse(response.body)
      expect(expected_repository["id"]).to eq(pull_request.id)
    end
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

end