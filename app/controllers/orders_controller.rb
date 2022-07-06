class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :render_services, only: %i[index new show edit update  ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_url, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def report
    render_services
    @orders = Order.all
    @total = report_total
    @descontos = orders_discount
    @valores_finais = orders_valor_final
    @final = report_final
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def render_services
      @services = Service.all
    end

    def report_total
      total = 0
      @orders.each do |order|
        total += order.service.valor * order.quantidade
      end
      total
    end

    def report_final
      final = 0
      @valores_finais.each {|valor| final+= valor}
      final
    end
    
    def orders_discount
      descontos = []
      @orders.each do |order|
        case order.quantidade
        when 10..19
          descontos << '10%'
        when 20..29
          descontos << '20%'
        when 30..Float::INFINITY
          descontos << '30%'
        else
          descontos << '0%'
        end
      end
      descontos
    end

    def orders_valor_final
      valores_finais = []
      @orders.each_with_index do |order, index|
        total = order.service.valor * order.quantidade
        desconto = @descontos[index].to_i / 100.0
        valores_finais << total - (total * desconto);
      end
      valores_finais
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:service_id,:quantidade, :funcionario, :data, :horaInicio, :horaFim, :detalhes)
    end
end
