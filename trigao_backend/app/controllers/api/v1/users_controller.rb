module Api
    module V1
        class UsersController < ApplicationController
            before_action :set_user, only: [:show, :update, :destroy]

            # GET /api/v1/users
            def index
                # `policy_scope` aplica a lógica da classe Scope da nossa UserPolicy
                @users = policy_scope(User)
                render json: @users
            end

            # GET /api/v1/users/:id
            def show
                # `authorize` verifica a permissão para a ação `show?`
                authorize @user
                render json: @user
            end

            # POST /api/v1/users
            def create
                @user = User.new(user_params)
                authorize @user # Verifica se o current_user tem permissão para :create?

                if @user.save
                render json: @user, status: :created
                else
                render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # PATCH/PUT /api/v1/users/:id
            def update
                authorize @user
                
                # Garante que apenas um 'master' possa alterar o 'role' de um usuário
                permitted_params = user_params
                permitted_params.delete(:role) unless current_user.master?

                if @user.update(permitted_params)
                render json: @user
                else
                render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /api/v1/users/:id
            def destroy
                authorize @user
                @user.destroy
                head :no_content
            end

            private

            # Usa o `policy_scope` também no `find` para garantir que um usuário
            # não possa sequer encontrar outro usuário que não deveria ver.
            def set_user
                @user = policy_scope(User).find(params[:id])
            end

            # Define os parâmetros permitidos para a criação e atualização de usuários.
            # Note que não permitimos a atualização de senha por aqui.
            def user_params
                params.require(:user).permit(:email, :password, :role)
            end
        end
    end
end