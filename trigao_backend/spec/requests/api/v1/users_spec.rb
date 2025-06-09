# spec/requests/api/v1/users_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/users" do
    let!(:master_user) { create(:user, :master) }
    let!(:padrao_user) { create(:user, :padrao) }

    context "quando não autenticado" do
      it "retorna 401 Unauthorized" do
        get '/api/v1/users'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "quando autenticado como usuário padrão" do
      it "retorna apenas o próprio usuário" do
        get '/api/v1/users', headers: authenticated_header(padrao_user)
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq(1)
        expect(json_response.first['id']).to eq(padrao_user.id)
      end
    end

    context "quando autenticado como usuário master" do
      it "retorna todos os usuários" do
        get '/api/v1/users', headers: authenticated_header(master_user)
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq(2)
      end
    end
  end

  describe "DELETE /api/v1/users/:id" do
    let(:master_user) { create(:user, :master) }
    let(:user_to_delete) { create(:user, :padrao) }
    
    context "quando autenticado como usuário master" do
      it "deleta o usuário com sucesso" do
        headers = authenticated_header(master_user)
        
        expect { 
          delete "/api/v1/users/#{user_to_delete.id}", headers: headers 
        }.to change(User, :count).by(-1)
        
        expect(response).to have_http_status(:no_content)
      end
    end
    
    context "quando autenticado como usuário padrão" do
      it "retorna 403 Forbidden" do
        # Tentativa de um usuário padrão deletar outro
        delete "/api/v1/users/#{master_user.id}", headers: authenticated_header(user_to_delete)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end