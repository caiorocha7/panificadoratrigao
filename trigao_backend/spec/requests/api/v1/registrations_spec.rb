# spec/requests/api/v1/registrations_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Registrations", type: :request do
  describe "POST /api/v1/signup" do
    context "com parâmetros válidos" do
      let(:valid_params) do
        { user: { email: 'novo_usuario@trigao.com', password: 'password123', role: 'padrao' } }
      end

      it "cria um novo usuário" do
        expect { post '/api/v1/signup', params: valid_params, as: :json }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "com parâmetros inválidos" do
      it "não cria um usuário com email já existente" do
        create(:user, email: 'existente@trigao.com')
        invalid_params = { user: { email: 'existente@trigao.com', password: 'password123' } }

        post '/api/v1/signup', params: invalid_params, as: :json
        
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['errors']).to include("Email has already been taken")
      end
    end
  end
end