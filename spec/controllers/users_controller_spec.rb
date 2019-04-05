require 'rails_helper'
 #data update
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

    describe "POST create" do
    it "returns http status created" do
      post :create, params: { name: "Pear" }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created user" do
      post :create, params: { name: "Tontin" }
      expected_user = JSON.parse(response.body)
      expect(expected_user).to have_key("id")
      expect(expected_user["name"]).to eq("Tontin")
    end
  end


  describe "PATCH update" do
    it "returns http status ok" do
      user = User.create(name: 'Cristian')
      patch :update, params: { name: 'Cristian', id: user.id, category: 'Hello' }
      expect(response).to have_http_status(:ok)
    end

    it "returns the updated user" do
      user = User.create(name: 'Ronnie')
      patch :update, params: { name: 'Ronnie', id: user.id, username: 'Ron' }
      expected_user = JSON.parse(response.body)
      expect(expected_user["name"]).to eq("Orange")
      expect(expected_user["username"]).to eq("Hola")
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
      user = User.create(name: 'Violet')
      delete :destroy, params: { id: user }
      expect(response).to have_http_status(:no_content)
    end

    it "returns empty body" do
      user = User.create(name: 'Cleare')
      delete :destroy, params: { id: user }
      expect(response.body).to eq(" ")
    end

    it "decrement by 1 the total of users" do
      user = User.create(name: 'Camie')
      expect do
        delete :destroy, params: { id: user }
      end.to change { User.count }.by(-1)
    end

    it "actually delete the user" do
      user = User.create(name: 'Akemi')
      delete :destroy, params: { id: user }
      user = User.where(id: user.id)
      expect(user.size).to eq(0)
    end
  end
  
end

  

  