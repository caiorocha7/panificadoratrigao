# app/controllers/api/v1/orders_controller.rb

class Api::V1::OrdersController < ApplicationController
  # `before_action :authenticate_user!` do ApplicationController é aplicado a todas as ações aqui.
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /api/v1/orders
  # Lista os pedidos de acordo com o escopo do usuário (próprios pedidos para 'padrao', todos para 'master').
  def index
    # O `policy_scope` filtra a coleção.
    # O `.includes` otimiza a query para buscar pedidos, seus itens e os produtos de cada item de forma eficiente.
    @orders = policy_scope(Order).includes(order_items: :product)
    render json: @orders
  end

  # GET /api/v1/orders/:id
  # Mostra os detalhes de um pedido específico.
  def show
    # `authorize` garante que o usuário só pode ver seu próprio pedido (ou qualquer um se for 'master').
    authorize @order
    render json: @order
  end

  # POST /api/v1/orders
  # Cria um novo pedido para o usuário atualmente logado.
  def create
    # `.build` cria o pedido já associado ao `current_user`, garantindo a propriedade correta.
    @order = current_user.orders.build(order_params)
    authorize @order
    
    if @order.save
      render json: @order, status: :created, location: api_v1_order_url(@order)
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/orders/:id
  # Atualiza um pedido.
  def update
    authorize @order
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/orders/:id
  # Remove/cancela um pedido.
  def destroy
    authorize @order
    @order.destroy
    head :no_content
  end

  private

  def set_order
    # Busca o pedido dentro do escopo autorizado para garantir que o usuário não acesse pedidos de outros.
    @order = policy_scope(Order).find(params[:id])
  end
  
  # Define os parâmetros permitidos para o pedido, incluindo os atributos aninhados para os itens do pedido.
  def order_params
    params.require(:order).permit(
      :payment_type, :total_amount, :status,
      # Permite um array de hashes para os `order_items`.
      # `:id` e `:_destroy` são necessários para atualizar e remover itens existentes em um pedido.
      order_items_attributes: [:id, :product_id, :quantity, :unit_price, :_destroy]
    )
  end
end