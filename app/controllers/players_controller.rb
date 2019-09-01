class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy, :store, :market]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
    respond_to do |format|
      format.html
      format.xml { render xml: @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    respond_to do |format|
      format.html
      format.xml { render xml: @player }
    end
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def store
    @product_items = ProductItem.where(player: @player)
    respond_to do |format|
      format.html
      format.xml { render xml: @product_items }
    end
  end

  def market
    @product_items = ProductItem.where(player: @player, trade_status: true)
    respond_to do |format|
      format.html
      format.xml { render xml: @product_items.to_xml(include:[:product]) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:nickname, :currency_amount)
    end
end
