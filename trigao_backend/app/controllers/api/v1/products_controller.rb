# app/controllers/api/v1/products_controller.rb

class Api::V1::ProductsController < ApplicationController
  # Permite que usuários não autenticados visualizem a lista de produtos e os detalhes de um produto.
  skip_before_action :authenticate_user!, only: [:index, :show]

  # Utiliza um método privado para buscar e definir o produto para as ações de membro, mantendo o código DRY.
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /api/v1/products
  # Retorna uma lista de produtos ativos.
  def index
    # `policy_scope` aplica o escopo definido em ProductPolicy::Scope.
    # `.includes(:category)` pré-carrega a categoria de cada produto, evitando N+1 queries.
    @products = policy_scope(Product).includes(:category).where(status: :active)
    render json: @products
  end

  # GET /api/v1/products/:id
  # Retorna os detalhes de um único produto.
  def show
    # `authorize` verifica se o usuário atual tem permissão para a ação :show? no @product.
    authorize @product
    render json: @product
  end

  # POST /api/v1/products
  # Cria um novo produto.
  def create
    @product = Product.new(product_params)
    # Garante que o usuário tem permissão para criar produtos antes de tentar salvar.
    authorize @product

    if @product.save
      render json: @product, status: :created, location: api_v1_product_url(@product)
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /api/v1/products/:id
  # Atualiza um produto existente.
  def update
    authorize @product
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/:id
  # Remove um produto.
  def destroy
    authorize @product
    @product.destroy
    # Retorna uma resposta 204 No Content, indicando sucesso sem corpo de resposta.
    head :no_content
  end

  private

  # Encontra o produto pelo ID fornecido na URL.
  # O `rescue_from ActiveRecord::RecordNotFound` no ApplicationController tratará o erro se o ID não for encontrado.
  def set_product
    @product = Product.find(params[:id])
  end

  # Define uma "lista segura" de parâmetros permitidos para o produto, prevenindo Mass Assignment.
  def product_params
    params.require(:product).permit(:code, :name, :category_id, :price, :unit, :stock_level, :status, :tax_info)
  end
end