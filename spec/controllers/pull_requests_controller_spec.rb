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
      expected_pull_request = JSON.parse(response.body)
      expect(expected_pull_request["id"]).to eq(pull_request.id)
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
      post :create, params: {
        title: 'Resolve #1',
        status: true,
        description: 'Resolve #1',
        branch_in: branch_master.id,
        branch_out: branch_1.id
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
      post :create, params: {
        title: 'Resolve #1',
        status: true,
        description: 'Resolve #1',
        branch_in: branch_master.id,
        branch_out: branch_1.id
      }
      expected_pull_request = JSON.parse(response.body)
      expect(expected_pull_request).to have_key("id")
      expect(expected_pull_request["title"]).to eq("Resolve #1")
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
      patch :update, params: { 
        id: pull_request,
        attributes: {
          status: false,
        }
      }
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
      patch :update, params: { 
        id: pull_request.id,
        attributes: {
          title: "updated", 
          status: false
        }
      }
      expected_pull = JSON.parse(response.body)
      expect(expected_pull["title"]).to eq("updated")
      expect(expected_pull["status"]).to eq("false")
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
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
      delete :destroy, params: { id: pull_request }
      expect(response).to have_http_status(:no_content)
    end
    it "returns empty body" do
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
      delete :destroy, params: { id: pull_request }
      expect(response.body).to eq(" ")
    end
    it "decrement by 1 the total of repositories" do
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
      expect do
        delete :destroy, params: { id: pull_request }
      end.to change { PullRequest.count }.by(-1)
    end
    it "actually delete the repository" do
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
      delete :destroy, params: { id: pull_request }
      deleted_pull_request = PullRequest.where(id: pull_request.id)
      expect(deleted_pull_request.size).to eq(0)
    end
  end

end