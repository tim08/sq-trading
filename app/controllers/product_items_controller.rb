class ProductItemsController < ApplicationController
  before_action :set_product_item, only: [:show, :edit, :update, :destroy, :to_sell, :update_sell,
                                          :withdraw_from_sale, :to_advertise, :buy]

  # GET /product_items
  # GET /product_items.json
  def index
    @product_items = ProductItem.all
  end

  # GET /product_items/1
  # GET /product_items/1.json
  def show
  end

  # GET /product_items/new
  def new
    @product_item = ProductItem.new
  end

  # GET /product_items/1/edit
  def edit
  end

  # POST /product_items
  # POST /product_items.json
  def create
    @product_item = ProductItem.new(product_item_params)

    respond_to do |format|
      if @product_item.save
        format.html { redirect_to @product_item, notice: 'Product item was successfully created.' }
        format.json { render :show, status: :created, location: @product_item }
      else
        format.html { render :new }
        format.json { render json: @product_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_items/1
  # PATCH/PUT /product_items/1.json
  def update
    respond_to do |format|
      if @product_item.update(product_item_params)
        format.html { redirect_to @product_item, notice: 'Product item was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_item }
      else
        format.html { render :edit }
        format.json { render json: @product_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def to_sell;end

  def update_sell
    respond_to do |format|
    if @product_item.check_available_number(product_item_params[:number]) && @product_item.valid?
      @product_item.split_stack(product_item_params)
      format.html { redirect_to store_player_path(@product_item.player), notice: 'Product item was successfully updated.' }
      format.xml  { render :show, status: :ok, location: @product_item }
    else
      @product_item.errors[:base] << "you do not have so many products"
      format.html { render :to_sell }
    end
      end
  end

  def withdraw_from_sale
    respond_to do |format|
      if @product_item.update_column(:trade_status, false)
        format.html { redirect_to market_player_path(@product_item.player), notice: 'Product item was successfully updated.' }
      end
    end
  end

  def to_advertise
    respond_to do |format|
      if @product_item.to_advertise
        format.html {  redirect_to market_player_path(@product_item.player), notice: 'Product item was successfully updated.' }
      end
    end
  end

  def buy
    respond_to do |format|
    if current_player
      if @product_item.buy(current_player)
      format.html { redirect_to adv_board_path, notice: 'Product item was buy'}
        end
    else
      format.html { redirect_to adv_board_path, notice: 'Need sing in'}
    end
      end
  end

  # DELETE /product_items/1
  # DELETE /product_items/1.json
  def destroy
    @product_item.destroy
    respond_to do |format|
      format.html { redirect_to product_items_url, notice: 'Product item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_item
      @product_item = ProductItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_item_params
      params.require(:product_item).permit(:player_id, :product_id, :number, :trade_status, :price)
    end
end
