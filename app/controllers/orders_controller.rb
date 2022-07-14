class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    set_orders
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.order_items.build
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Заказ был успешно создан." }
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
        format.html { redirect_to order_url(@order), notice: "Заказ был успешно обновлен." }
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
      format.html { redirect_to orders_url, notice: "Заказ был успешно удален." }
      format.json { head :no_content }
    end
  end

  def export
    set_orders

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=orders_#{Time.now.strftime('%Y-%m-%d %H_%M_%S')}.xlsx"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.includes(order_items: [{service: :category}, :worker]).find(params[:id])
    end

    def set_orders
      @orders = Order.includes(order_items: [:worker, {service: :category}])

      @orders = @orders.order_by_date(params[:order_by_date]) if params[:order_by_date].present?
      @orders = @orders.order_by_customer_name(params[:order_by_customer_name]) if params[:order_by_customer_name].present?
      @orders = @orders.order_by_category(params[:order_by_category]) if params[:order_by_category].present?
      @orders = @orders.order_by_service(params[:order_by_service]) if params[:order_by_service].present?
      @orders = @orders.order_by_worker(params[:order_by_worker]) if params[:order_by_worker].present?

      @orders = @orders.filter_by_date_from(params[:filter_by_date_from]) if params[:filter_by_date_from].present?
      @orders = @orders.filter_by_date_to(params[:filter_by_date_to]) if params[:filter_by_date_to].present?
      @orders = @orders.filter_by_customer_name(params[:filter_by_customer_name]) if params[:filter_by_customer_name].present?
      @orders = @orders.filter_by_category(params[:filter_by_category]) if params[:filter_by_category].present?
      @orders = @orders.filter_by_service(params[:filter_by_service]) if params[:filter_by_service].present?
      @orders = @orders.filter_by_worker(params[:filter_by_worker]) if params[:filter_by_worker].present?
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer_name, order_items_attributes: [:id, :service_id, :worker_id, :_destroy])
    end
end
