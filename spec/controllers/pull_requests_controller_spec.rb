require 'rails_helper'

describe PullRequestsController do 
  
  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

end