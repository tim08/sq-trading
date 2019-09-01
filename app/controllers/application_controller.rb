class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_player
    @_current_player ||= session[:current_player_id] &&
        Player.find_by(id: session[:current_player_id])
  end
end
