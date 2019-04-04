require 'rails_helper'
 
describe UsersController do
  before do
    User.delete_all
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  it 'render json with all users' do
    User.create(
      username: 'Cuevita',
      name: 'Pedro',
      birthday: '10/11/1990',
      email: 'cuevitasmalo666@gmail.com',
      bio: 'Es muy malo malo jugando pelota',
      company: 'Maldad Pura',
      location: 'Los olvidados de Dios',
      website: 'nodebojugarfutbol@cojo.pe' 
      )
    get :index
    users = JSON.parse(response.body)
    expect(users.size).to eq 1
  end
  
  describe 'GET show' do
    it 'returns http status ok' do
      user = User.create(
        username: 'Cuevita',
        name: 'Pedro',
        birthday: '10/11/1990',
        email: 'cuevitasmalo666@gmail.com',
        bio: 'Es muy malo malo jugando pelota',
        company: 'Maldad Pura',
        location: 'Los olvidados de Dios',
        website: 'nodebojugarfutbol@cojo.pe' 
        )
      get :show, params: { id: user }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct user' do
      user = User.create(
        username: 'Cuevita',
        name: 'Pedro',
        birthday: '10/11/1990',
        email: 'cuevitasmalo666@gmail.com',
        bio: 'Es muy malo malo jugando pelota',
        company: 'Maldad Pura',
        location: 'Los olvidados de Dios',
        website: 'nodebojugarfutbol@cojo.pe' 
        )
      get :show, params: { id: user }
      expected_user = JSON.parse(response.body)
      expect(expected_user["id"]).to eq(user.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  
end

  

  