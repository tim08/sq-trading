class MainController < ApplicationController
  def index
    @player = Player.first
    @current_player = current_player
  end

  def adv_board
    @product_items = ProductItem.search(params)
    respond_to do |format|
      format.html
      format.xml { render xml: @product_items.to_xml(include:[:product]) }
    end
  end

  def create_session
    if player = Player.find(params[:player_id])
      session[:current_player_id] = player.id
      redirect_to root_url
    end
  end

  def destroy_session
      session.delete(:current_player_id)
      @_current_player = nil
      redirect_to root_url
  end
end
